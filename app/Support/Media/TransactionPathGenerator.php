<?php

namespace App\Support\Media;

use Spatie\MediaLibrary\MediaCollections\Models\Media;
use Spatie\MediaLibrary\Support\PathGenerator\PathGenerator;
use App\Helpers\TransactionMediaPath;

class TransactionPathGenerator implements PathGenerator
{
    public function getPath(Media $media): string
    {
        return TransactionMediaPath::generate($media->model) . '/';
    }

    public function getPathForConversions(Media $media): string
    {
        return TransactionMediaPath::generate($media->model) . '/conversions/';
    }

    public function getPathForResponsiveImages(Media $media): string
    {
        return TransactionMediaPath::generate($media->model) . '/responsive/';
    }
}
