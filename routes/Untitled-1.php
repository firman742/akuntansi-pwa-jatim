<?php

namespace App\Concerns\RabbitMQ;

use App\Console\Commands\RabbitMQAppListen;
use App\Domains\Finance\Enums\TransactionMethod;
use App\Domains\Finance\Models\Bill\Bill;
use App\Domains\Finance\Models\Cost\Cost;
use App\Domains\Finance\Models\Cost\StudentCost;
use App\Domains\Finance\Services\Bill\BillPaymentService;
use App\Domains\Finance\Services\Bill\BillService;
use App\Domains\Finance\Services\Cost\CostStudentService;
use App\Enums\DefaultRole;
use App\Enums\IntegratedApps;
use App\Enums\OptionReferenceType;
use App\Enums\RabbitMQ\RabbitMQRoutingKey;
use App\Exceptions\CidException;
use App\Models\Geo\City;
use App\Models\Geo\District;
use App\Models\Geo\Province;
use App\Models\Geo\SubDistrict;
use App\Models\Institution;
use App\Models\Student;
use App\Models\User;
use App\Repositories\OptionReferenceRepository;
use App\Services\Guardian\GuardianService;
use App\Services\ModelIntegration\ModelIntegrationService;
use App\Services\People\PeopleService;
use App\Services\Student\StudentGuardianService;
use App\Services\Student\StudentService;
use App\Services\User\UserService;
use Carbon\Carbon;
use Illuminate\Contracts\Container\BindingResolutionException;
use Illuminate\Support\Facades\DB;
use Spatie\MediaLibrary\MediaCollections\Exceptions\FileDoesNotExist;
use Spatie\MediaLibrary\MediaCollections\Exceptions\FileIsTooBig;
use Throwable;

trait ConsumeStudent
{

    /**
     * @return ConsumeStudent|RabbitMQAppListen
     * @throws BindingResolutionException
     * @throws CidException
     * @throws FileDoesNotExist
     * @throws FileIsTooBig
     * @throws Throwable
     */
    protected function rkTransferApplicantToStudent(): self
    {
        if (
            !$this->_isMessageConsumed &&
            $this->_message->getRoutingKey() === RabbitMQRoutingKey::RK_APPLICANT_TRANSFER->value
        ) {
            DB::beginTransaction();

            $data = json_decode(json_encode($this->_messageBody), true);

            $studentData = $data['student_data'];
            $inputs = [
                'student' => array_merge($studentData, ['is_auto_nis' => !isset($studentData['nis'])]),
                'user' => $studentData['user'],
                'people' => $studentData['people'],
                'with_exist_guardian' => $studentData['with_exist_guardian'] ?? [],
                'guardian' => $studentData['guardian'] ?? [],
            ];

            $optionReferenceRepository = app()->make(OptionReferenceRepository::class);

            $inputs['people']['religion_id'] = $inputs['people']['religion_code'] ?
                $optionReferenceRepository->getByTypeAndCode(
                    OptionReferenceType::RELIGION,
                    $inputs['people']['religion_code']
                )->id : null;

            if (!empty($inputs['people']['addresses'])) {
                foreach ($inputs['people']['addresses'] as $key => $address) {
                    $inputs['people']['addresses'][$key] = $this->formatAddressData($address);
                }
            }

            foreach ($inputs['guardian'] as $key => $guardian) {
                $inputs['guardian'][$key]['religion_id'] = $guardian['religion_code'] ?
                    $optionReferenceRepository->getByTypeAndCode(
                        OptionReferenceType::RELIGION,
                        $guardian['religion_code']
                    )->id : null;

                if (!empty($guardian['addresses'])) {
                    foreach ($guardian['addresses'] as $i => $address) {
                        $inputs['guardian'][$key]['addresses'][$i] = $this->formatAddressData($address);
                    }
                }
            }

            $inputs = $this->cleanArray($inputs);

            $student = Student::byInstitution($data['institution_id'])
                ->where('registration_number', $studentData['registration_number'])
                ->first();

            /** @var Institution $institution */
            $institution = Institution::query()
                ->findOrFail($data['institution_id']);

            if (is_null($student)) {
                $student = (new StudentService())
                    ->addNewData(
                        institution: $institution,
                        requestedData: $inputs,
                        isTransactional: false,
                    );
                     // Binding to model Integration
                (new ModelIntegrationService())->create(
                    institution: $institution,
                    integrationable: $student,
                    inputs: [
                        'source' => IntegratedApps::CID_ADMISSION->value,
                        'integration_id' => $data['ref_id'],
                    ]
                );
            } else {
                $inputs['user'] = array_merge(
                    $inputs['user'],
                    ['name' => $inputs['people']['name']]
                );

                (new StudentService())->updateDataById(
                    student: $student,
                    requestedData: $inputs['student'],
                    isTransactional: false
                );

                (new UserService())->updateDataById(
                    user: $student->user,
                    requestedData: $inputs['user'],
                    role: null,
                    isTransactional: false
                );

                (new PeopleService())->updateDataById(
                    people: $student->people,
                    requestedData: $inputs['people']
                );

                foreach ($inputs['guardian'] as $guardian) {
                    $guardianRelation = $optionReferenceRepository->getByTypeAndCode(
                        OptionReferenceType::GUARDIAN_RELATION_TYPE,
                        $guardian['guardian_relation_code']
                    );

                    $guardianExist = $student->guardians()->whereHas('guardian_relation', function ($query) use ($guardianRelation) {
                        $query->where('id', $guardianRelation->id);
                    })->first();

                    if ($guardianExist) {
                        (new StudentGuardianService())->updateDataById(
                            student: $student,
                            guardian: $guardianExist,
                            requestedData: array_merge(
                                $guardian,
                                [
                                    'people_id' => $guardianExist->people->id,
                                    'guardian_relation_id' => $guardianRelation->id
                                ]
                            ),
                            isTransactional: false,
                        );
                        if ($guardian['is_guardian']) {
                            if ($guardianExist->user instanceof User) {
                                (new UserService())->updateDataById(
                                    user: $guardianExist->user,
                                    requestedData: $guardian,
                                    role: null,
                                    isTransactional: false
                                );
                            } else {
                                (new UserService())->addNewData(
                                    requestedData: array_merge(
                                        $guardian,
                                        ['username' => generateUsernameFromName($guardian['name'])]
                                    ),
                                    institutionIds: [$institution->id],
                                    userable: $guardianExist,
                                    role: DefaultRole::GUARDIAN,
                                    isTransaction: false
                                );
                            }
                        } else {
                            //TODO delete user for guardian
                        }
                    } else {
                        (new GuardianService())
                            ->addNewData(
                                requestedData: $guardian,
                                guardianRelation: $guardianRelation,
                                student: $student,
                                institution: $institution,
                            );
                    }
                }
            }

            DB::commit();

            DB::beginTransaction();

            if (!empty($data['bill'])) {

                $sysAdminAccount = User::query()
                    ->where('username', 'sys_admin')
                    ->where('userable_type', null)
                    ->where('userable_id', null)
                    ->firstOrFail();

                foreach ($data['bill'] as $admissionBill) {

                    /** @var Cost $cost */
                    $cost = Cost::query()
                        ->where('id', $admissionBill['cost_id'])
                        ->firstOrFail();

                    $studentCost = $student->user->studentCosts->where('cost_id', $cost->id)->first();

                    $billAmount = (int)($admissionBill['last_config']['origin_amount'] ?? 0);
                    
                    if (empty($studentCost)) {
                        $studentCost = $this->createStudentCost(
                            performed: $sysAdminAccount,
                            cost: $cost,
                            student: $student,
                            amount: $billAmount
                        );

                        $bill = $this->createBill(
                            performed: $sysAdminAccount,
                            student: $student,
                            studentCost: $studentCost,
                        );

                        $this->createPayment(
                            bill: $bill,
                            transactionMethod: TransactionMethod::from($admissionBill['payment_method'] ?? null),
                            amount: $admissionBill['payment_amount'] ?? null
                        );
                    }
                }
            }

            DB::commit();

            $this->acknowledge();
            echo 'Transfer applicant to student ' . $this->_messageBody->student_data->registration_number, "\n";
        }

        return $this;
    }

    private function cleanArray(array $input): array
    {
        foreach ($input as &$value) {
            if (is_array($value)) {
                $value = $this->cleanArray($value);
            }
        }

        return array_filter($input, function ($value) {
            return $value !== null && $value !== '';
        });
    }

    /**
     *
     * @param array $address
     * @return array
     */
    public function formatAddressData(array $address): array
    {
        return [
            'name' => $address['name'] ?? 'anonymous',
            'address' => $address['address'] ?? null,
            'phone' => $address['phone'] ?? null,
            'rt_rw' => $address['rt_rw'] ?? null,
            'zip_code' => $address['zip_code'] ?? null,
            'sub_district_id' => !empty($address['sub_district_code'])
                ? SubDistrict::query()->where('code', $address['sub_district_code'])->first()?->id
                : null,
            'district_id' => !empty($address['district_code'])
                ? District::query()->where('code', $address['district_code'])->first()?->id
                : null,
            'city_id' => !empty($address['city_code'])
                ? City::query()->where('code', $address['city_code'])->first()?->id
                : null,
            'province_id' => !empty($address['province_code'])
                ? Province::query()->where('code', $address['province_code'])->first()?->id
                : null,
            'type' => $address['type'] ?? null,
        ];
    } /**
     * @throws Throwable
     * @throws CidException
     */
    private function createStudentCost(User $performed, Cost $cost, Student $student, int $amount): StudentCost
    {
        $studentCosts = (new CostStudentService())
            ->addNewData(
                performed: $performed,
                institution: $student->institution,
                requestedData: [
                    'period_id' => $student->period->id,
                    'is_created_bill' => false,
                    'cost_date' => [
                        [
                            'cost_id' => $cost->id,
                            'date' => [
                                Carbon::now()->format('Y-m')
                            ],
                        ]
                    ],
                    "costs_data" => [
                        "user_id" => $student->user->id,
                        "grouping_costs" => [
                            [
                                "type" => $cost->costType->name,
                                "costable_id" => $student->user->id,
                                "cost_details" => [
                                    [
                                        "cost_id" => $cost->id,
                                        "amount" => $amount,
                                        "discount" => null,
                                    ]
                                ]
                            ]
                        ]
                    ]

                ],
                isTransactional: false
            );

        return $studentCosts->first()['referenceable'];
    }

