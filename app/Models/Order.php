<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'token', 'user_id', 'rider_id', 'payment_id', 'status_id', 'reason', 'note', 'fare', 'delivery', 'when', 'ship_from', 'ship_to', 'latitude', 'longitude'
    ];   
}
