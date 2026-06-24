<?php

namespace App\Models\Abstracts;

use Exception;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Override;

abstract class BaseModelAuthenticated extends Authenticatable
{
    protected array $relationshipToCheck = [];

    protected string $activityModule = 'BaseModel';

    public function getActivityModule(): string
    {
        return $this->activityModule;
    }

    /**
     * Check if the model has any related entities based on the defined relationships.
     *
     * @return bool
     */
    public function hasRelatedEntities(): bool
    {
        foreach ($this->relationshipToCheck as $relationship) {
            if ($this->$relationship()->exists()) {
                return true;
            }
        }
        return false;
    }

    /**
     * Get the related entities based on the defined relationships.
     *
     * @return array
     */
    public function getRelatedEntities(): array
    {
        $relatedEntities = [];
        foreach ($this->relationshipToCheck as $relationship) {
            if ($this->$relationship()->exists()) {
                $relatedEntities[$relationship] = $this->$relationship()->get();
            }
        }
        return $relatedEntities;
    }
}