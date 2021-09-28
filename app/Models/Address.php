<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'status_id', 'user_id', 'street', 'area', 'note', 'type', 'latitude', 'longitude'
    ];   
}
