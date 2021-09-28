<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Rider extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'rider_code', 'username', 'password', 'status_id', 'latitude', 'longitude', 'firstname', 'middlename', 'lastname', 'gender', 'dateofbirth', 'email', 'cellphone', 'birthofplace', 'civilstatus', 'citizenship', 'height', 'weight', 'religion', 'cityaddress', 'provincialaddress', 'elementary', 'highschool', 'college', 'nbiclearance', 'resume'
    ];   
}
