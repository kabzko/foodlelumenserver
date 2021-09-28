<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RiderSession extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'session_id', 'rider_id', 'remitted'
    ];   
}
