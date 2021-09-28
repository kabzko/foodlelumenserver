<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Store extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'streets', 'preparing_time', 'express', 'latitude', 'longitude', 'close_day', 'open_time_a', 'open_time_b', 'status_id', 'storebanner', 'orderbanner', 'storethumbnail', 'tin', 'username', 'password'
    ];   
}
