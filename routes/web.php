<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

// USER API
$router->post('/home_detail', 'UserController@home_detail');
$router->post('/search_shop_restaurant', 'UserController@search_shop_restaurant');
$router->post('/search_products', 'UserController@search_products');
$router->post('/stores', 'UserController@stores');
$router->post('/store_detail', 'UserController@store_detail');
$router->post('/products', 'UserController@products');
$router->post('/product_detail', 'UserController@product_detail');
$router->post('/check_cart', 'UserController@check_cart');
$router->post('/product_addcart', 'UserController@product_addcart');
$router->post('/product_update', 'UserController@product_update');
$router->post('/cart', 'UserController@cart');
$router->post('/cart_detail', 'UserController@cart_detail');
$router->post('/cart_update', 'UserController@cart_update');
$router->post('/cart_remove', 'UserController@cart_remove');
$router->post('/cart_empty', 'UserController@cart_empty');
$router->post('/favourites', 'UserController@favourites');
$router->post('/favourite_add', 'UserController@favourite_add');
$router->post('/favourite_remove', 'UserController@favourite_remove');
$router->post('/checkout_detail', 'UserController@checkout_detail');
$router->post('/place_order', 'UserController@place_order');
$router->post('/orders', 'UserController@orders');
$router->post('/order_detail', 'UserController@order_detail');
$router->post('/verify', 'UserController@verify');
$router->post('/register', 'UserController@register');
$router->post('/login', 'UserController@login');
$router->post('/address', 'UserController@address');
$router->post('/address_detail', 'UserController@address_detail');
$router->post('/address_create', 'UserController@address_create');
$router->post('/address_update', 'UserController@address_update');
$router->post('/address_delete', 'UserController@address_delete');
$router->post('/address_select', 'UserController@address_select');
$router->post('/user', 'UserController@user');
$router->post('/user_update', 'UserController@user_update');
$router->post('/send_code', 'UserController@send_code');
$router->post('/load_open_ticket', 'UserController@load_open_ticket');
$router->post('/submit_ticket', 'UserController@submit_ticket');
$router->post('/load_chatbox', 'UserController@load_chatbox');
$router->post('/send_message', 'UserController@send_message');
$router->post('/cancel_order', 'UserController@cancel_order');
$router->post('/re_oder', 'UserController@re_oder');
$router->post('/update_forgot_password', 'UserController@update_forgot_password');

// STORE API
$router->post('/store_login', 'StoreController@store_login');
$router->post('/store_logout', 'StoreController@store_logout');
$router->post('/store_active_orders', 'StoreController@store_active_orders');
$router->post('/store_add_riders', 'StoreController@store_add_riders');
$router->post('/store_order_detail', 'StoreController@store_order_detail');
$router->post('/store_order_cancel', 'StoreController@store_order_cancel');
$router->get('/store_order_accept', 'StoreController@store_order_accept');
$router->post('/store_change_rider', 'StoreController@store_change_rider');
$router->post('/store_item_detail', 'StoreController@store_item_detail');
$router->post('/store_item_remove', 'StoreController@store_item_remove');
$router->post('/store_item_update', 'StoreController@store_item_update');
$router->post('/store_store_detail', 'StoreController@store_store_detail');
$router->post('/store_product_detail', 'StoreController@store_product_detail');
$router->post('/store_add_order', 'StoreController@store_add_order');
$router->post('/store_past_orders', 'StoreController@store_past_orders');
$router->post('/store_products', 'StoreController@store_products');
$router->post('/store_category', 'StoreController@store_category');
$router->post('/store_save_new_product', 'StoreController@store_save_new_product');
$router->post('/store_search_products', 'StoreController@store_search_products');
$router->post('/store_update_product', 'StoreController@store_update_product');
$router->post('/store_enable_product', 'StoreController@store_enable_product');
$router->post('/store_disable_product', 'StoreController@store_disable_product');
$router->post('/store_profile', 'StoreController@store_profile');
$router->post('/store_load_open_ticket', 'StoreController@store_load_open_ticket');
$router->post('/store_submit_ticket', 'StoreController@store_submit_ticket');
$router->post('/store_load_chatbox', 'StoreController@store_load_chatbox');
$router->post('/store_send_message', 'StoreController@store_send_message');
$router->post('/store_update_password', 'StoreController@store_update_password');

// RIDER API
$router->post('/rider_login', 'RiderController@rider_login');
$router->post('/rider_logout', 'RiderController@rider_logout');
$router->post('/rider_active_delivery', 'RiderController@rider_active_delivery');
$router->post('/rider_order_delivery', 'RiderController@rider_order_delivery');
$router->post('/rider_accept_delivery', 'RiderController@rider_accept_delivery');
$router->post('/rider_decline_delivery', 'RiderController@rider_decline_delivery');
$router->post('/rider_complete_delivery', 'RiderController@rider_complete_delivery');
$router->post('/rider_complete_orders', 'RiderController@rider_complete_orders');
$router->post('/rider_update_location', 'RiderController@rider_update_location');
$router->post('/rider_profile', 'RiderController@rider_profile');
$router->post('/rider_update_password', 'RiderController@rider_update_password');
$router->post('/rider_load_open_ticket', 'RiderController@rider_load_open_ticket');
$router->post('/rider_submit_ticket', 'RiderController@rider_submit_ticket');
$router->post('/rider_load_chatbox', 'RiderController@rider_load_chatbox');
$router->post('/rider_send_message', 'RiderController@rider_send_message');
