<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

use App\Models\User;
use App\Models\Store;
use App\Models\Favourite;
use App\Models\Product;
use App\Models\Cart;
use App\Models\Payment;
use App\Models\Fare;
use App\Models\Order;
use App\Models\Purchase;
use App\Models\Address;
use App\Models\Ticket;
use App\Models\Chat;

class UserController extends Controller
{
    public function LatLngToKM($lat1, $lng1, $lat2, $lng2)
    {
        $r = 6371;
        $p1 = $lat1 * (M_PI/180);
        $p2 = $lat2 * (M_PI/180);
        $dp = ($lat2-$lat1) * (M_PI/180);
        $dl = ($lng2-$lng1) * (M_PI/180);
        $a = sin($dp/2) * sin($dp/2) + cos($p1) * cos($p2) * sin($dl/2) * sin($dl/2);
        $c = 2 * atan2(sqrt($a), sqrt(1-$a));
        $d = $r * $c;
        return $d;
    }

    public function home_detail(Request $request)
    {
        $nearme = [];
        $userid = $request->input("userid");
        $mylat = $request->input("lat");
        $mylng = $request->input("lng");
        $stores = Store::select("id", "name", "storethumbnail", "latitude", "longitude")->where("close_day", "!=", date("l"))->where("open_time_a", "<=", date('H:i:s'))->where("open_time_b", ">=", date('H:i:s'))->inRandomOrder()->limit(6)->get();
        foreach ($stores as $x) {
            $data = $this->LatLngToKM($mylat, $mylng, $x->latitude, $x->longitude);
            if($data <= 10) {
                array_push($nearme, (object)["id" => $x->id, "name" => $x->name, "storethumbnail" => $x->storethumbnail]);
            }
        }
        return response()->json([
            "nearme" => $nearme,
            "cart" => Cart::join("products","carts.product_id","=","products.id")->where("carts.user_id", $userid)->count(),
            "favourites" => Favourite::join("stores","favourites.store_id","=","stores.id")->select("stores.id", "stores.name", "stores.storethumbnail", "stores.close_day", "stores.open_time_a", "stores.open_time_b")->where("user_id", $userid)->get(),
            "current_time" => date('H:i:s')
        ]);
    }

    public function search_shop_restaurant(Request $request)
    {
        $search = $request->input("search");
        $userid = $request->input("userid");                                                                                  
        return response()->json([
            "stores" => Store::select("id", "streets", "name", "preparing_time", "close_day", "open_time_a", "open_time_b", "orderbanner")->where("name", "like", "%".$search."%")->get(),
            "random" => Store::select("id", "streets", "name", "preparing_time", "close_day", "open_time_a", "open_time_b", "orderbanner")->where("name", "not like", "%".$search."%")->inRandomOrder()->get(),
            "favourites" => Favourite::select("id", "store_id")->where("user_id", $userid)->get(),
            "current_time" => date('H:i:s')
        ]);
    }

    public function search_products(Request $request)
    {
        $search = $request->input("search");
        $storeid = $request->input("storeid");
        return Product::select("id", "name", "price", "store_id", "image")->where("status_id", 1)->where("store_id", $storeid)->where(function($query) use ($search){$query->where("name", "like", "%".$search."%")->orWhere("category", "like", "%".$search."%");})->get();
    }

    public function stores(Request $request)
    {
        $store = [];
        $mylat = $request->input("lat");
        $mylng = $request->input("lng");
        $stores = Store::select("id", "name", "storethumbnail", "latitude", "longitude", "close_day")->where("open_time_a", "<=", date('H:i:s'))->where("open_time_b", ">=", date('H:i:s'))->orderBy("name", "asc")->get();
        foreach ($stores as $x) {
            $data = $this->LatLngToKM($mylat, $mylng, $x->latitude, $x->longitude);
            if($data <= 10) {
                array_push($store, (object)["id" => $x->id, "name" => $x->name, "storethumbnail" => $x->storethumbnail]);
            }
        }
        return $store;
    }

    public function store_detail(Request $request)
    {
        $userid = $request->input("userid");
        $storeid = $request->input("storeid");
        return response()->json([
            "favourite" => Favourite::select("id")->where("user_id", $userid)->where("store_id", $storeid)->get(),
            "cart" => Cart::join("products","carts.product_id","=","products.id")->where("carts.user_id", $userid)->where("products.store_id", $storeid)->count(),
            "store" => Product::join("stores","products.store_id","=","stores.id")->select("stores.name", "stores.storebanner", "stores.close_day", "stores.open_time_a", "stores.open_time_b")->where("products.store_id", $storeid)->get(),
            "products" => Product::select("id", "name", "price", "category", "store_id", "image")->where("status_id", 1)->where("store_id", $storeid)->get(),
            "category" => Product::select("category")->where("status_id", 1)->where("store_id", $storeid)->groupBy("category")->get(),
            "current_time" => date('H:i:s')
        ]);
    }

    public function products(Request $request)
    {
        $category = $request->input("category");
        return Product::select("id", "name", "price", "store_id", "image")->where("status_id", 1)->where("category", $category)->get();
    }

    public function product_detail(Request $request)
    {
        $userid = $request->input("userid");
        $productid = $request->input("productid");
        return response()->json([
            "cart" => Cart::join("products","carts.product_id","=","products.id")->where("carts.user_id", $userid)->count(),
            "product" => Product::select("id", "name", "price", "description", "choices", "image")->where("id", $productid)->get()
        ]);
    }

    public function check_cart(Request $request)
    {
        $userid = $request->input("userid");
        $storeid = $request->input("storeid");
        return Cart::join("products","carts.product_id","=","products.id")->where("carts.user_id", $userid)->where("products.store_id", "!=", $storeid)->count();
    }

    public function cart_empty(Request $request)
    {
        $userid = $request->input("userid");
        Cart::where("user_id", $userid)->delete();
        return 1;
    }

    public function product_addcart(Request $request)
    {
        $userid = $request->input("userid");
        $productid = $request->input("productid");
        $choices = $request->input("choices");
        $quantity = $request->input("quantity");
        $availability = $request->input("availability");
        $instruction = $request->input("instruction");
        $check = Cart::select("quantity")->where("user_id", $userid)->where("product_id", $productid)->where("selected_choices", $choices)->get();
        if ($check->isEmpty()) {
            Cart::create(["user_id" => $userid, "product_id" => $productid, "selected_choices" => $choices, "quantity" => $quantity, "instruction" => $instruction, "availability" => $availability]);
            return 1;
        } else {
            Cart::where("user_id", $userid)->where("product_id", $productid)->where("selected_choices", $choices)->update(["quantity" => $check[0]->quantity + $quantity]);
            return 1;
        }
    }

    public function product_update(Request $request)
    {
        $cartid = $request->input("cartid");
        $choices = $request->input("choices");
        $quantity = $request->input("quantity");
        $instruction = $request->input("instruction");
        $availability = $request->input("availability");
        Cart::where("id", $cartid)->update(["selected_choices" => $choices, "quantity" => $quantity, "instruction" => $instruction, "availability" => $availability]);
        return 1;
    }

    public function cart(Request $request)
    {
        $userid = $request->input("userid");
        return response()->json([
            "fares" => Fare::select("minimum_distance", "minimum_charge", "increment_amount")->get(),
            "products" => Cart::join("products","carts.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("carts.id", "carts.product_id", "products.name", "products.price", "carts.selected_choices","carts.quantity","carts.instruction","carts.availability")->where("carts.user_id", $userid)->get(),
            "store" => Cart::join("products","carts.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("stores.name", "stores.preparing_time", "stores.delivery_type", "stores.latitude", "stores.longitude", "stores.close_day", "stores.open_time_a", "stores.open_time_b")->where("carts.user_id", $userid)->get(),
            "current_time" => date('H:i:s')
        ]);
    }

    public function cart_detail(Request $request)
    {
        $cartid = $request->input("cartid");
        return Cart::join("products","carts.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("products.name", "products.price", "products.image", "products.description", "carts.selected_choices","carts.quantity","carts.instruction","carts.availability")->where("carts.id", $cartid)->get();
    }

    public function cart_update(Request $request)
    {
        $cartid = $request->input("cartid");
        $quantity = $request->input("quantity");
        Cart::where("id", $cartid)->update(["quantity" => $quantity]);
        return 1;
    }

    public function cart_remove(Request $request)
    {
        $cartid = $request->input("cartid");
        Cart::where("id", $cartid)->delete();
        return 1;
    }

    public function favourites(Request $request)
    {
        $userid = $request->input("userid");
        return response()->json([
            "favourites" => Favourite::join("stores","favourites.store_id","=","stores.id")->select("stores.id", "stores.name", "stores.storethumbnail", "stores.close_day", "stores.open_time_a", "stores.open_time_b")->where("user_id", $userid)->get(),
            "current_time" => date('H:i:s')
        ]);
    }

    public function favourite_add(Request $request)
    {
        $userid = $request->input("userid");
        $storeid = $request->input("storeid");
        Favourite::create(["user_id" => $userid, "store_id" => $storeid]);
        return 1;
    }

    public function favourite_remove(Request $request)
    {
        $favouriteid = $request->input("favouriteid");
        Favourite::where("id", $favouriteid)->delete();
        return 1;
    }

    public function checkout_detail(Request $request)
    {
        $userid = $request->input("userid");
        return response()->json([
            "payment" => Payment::select("type", "disable")->get(),
            "address" => Address::join("address_status","addresses.status_id","=","address_status.id")->where("user_id", $userid)->where("address_status.name", "Used")->get() 
        ]);
    }

    public function place_order(Request $request)
    {
        $count = Order::whereDate("created_at", date("Y-m-d"))->count();
        $userid = $request->input("userid");
        $paymentid = $request->input("paymentid");
        $token = date("Ymd").$count;
        $note = $request->input("note");
        $fare = $request->input("fare");
        $shipFrom = $request->input("shipFrom");
        $shipTo = $request->input("shipTo");
        $cart = $request->input("cart");
        $statusId = 1;
        $lat = $request->input("lat");
        $lng = $request->input("lng");
        $delivery = $request->input("delivery");
        $when = $request->input("when");
        $order_id = Order::create(["token" => $token, "user_id" => $userid, "payment_id" => $paymentid, "status_id" => $statusId, "note" => $note, "fare" => $fare, "delivery" => $delivery, "when" => $when, "ship_from" => $shipFrom, "ship_to" => $shipTo, "latitude" => $lat, "longitude" => $lng])->id;
        foreach (json_decode($cart) as $value) {
            Purchase::create(["order_id" => $order_id, "product_id" => $value->product_id, "price" => $value->price, "selected_choices" => $value->selected_choices, "quantity" => $value->quantity, "instruction" => $value->instruction, "availability" => $value->availability, "status_id" => $statusId]);
        }
        Cart::where("user_id", $userid)->delete();
        return 1;
    }

    public function orders(Request $request)
    {
        $userid = $request->input("userid");
        return response()->json([
            "active" => Purchase::join("orders","purchases.order_id","=","orders.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("orders.id", "orders.token", "orders.delivery", "orders.when", "stores.orderbanner", "stores.name", "orders.fare", "purchases.price", "purchases.selected_choices", "purchases.quantity")->selectRaw('CONCAT(SUBSTRING(DAYNAME(orders.created_at), 1, 3), ", ", SUBSTRING(MONTHNAME(orders.created_at), 1, 3), " ", DAY(orders.created_at), ", ", YEAR(orders.created_at), " ", TIME_FORMAT(TIME(orders.created_at), "%h:%i:%s %p")) as datetime')->where(function($query){$query->where('orders.status_id', "1")->orWhere('orders.status_id', "2");})->where("orders.user_id", $userid)->orderBy("orders.created_at", "desc")->get(),
            "past" => Purchase::join("orders","purchases.order_id","=","orders.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("orders.id", "orders.token", "orders.when", "stores.orderbanner", "stores.name", "orders.fare", "purchases.price", "purchases.selected_choices", "purchases.quantity")->selectRaw('CONCAT(SUBSTRING(DAYNAME(orders.created_at), 1, 3), ", ", SUBSTRING(MONTHNAME(orders.created_at), 1, 3), " ", DAY(orders.created_at), ", ", YEAR(orders.created_at), " ", TIME_FORMAT(TIME(orders.created_at), "%h:%i:%s %p")) as datetime')->where(function($query){$query->where('orders.status_id', "3")->orWhere('orders.status_id', "4");})->where("orders.user_id", $userid)->orderBy("orders.created_at", "desc")->get()
        ]);
    }

    public function order_detail(Request $request)
    {
        $orderid = $request->input("orderid");
        return Purchase::join("orders","purchases.order_id","=","orders.id")->join("order_status","orders.status_id","=","order_status.id")->join("purchase_status","purchases.status_id","=","purchase_status.id")->join("payments","orders.payment_id","=","payments.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("payments.type", "orders.id", "orders.delivery", "orders.when", "order_status.name as orderstatus", "purchase_status.name as purchasestatus", "stores.streets", "stores.name as store", "orders.token", "orders.fare", "products.name", "products.store_id as storeid", "purchases.price", "purchases.selected_choices", "purchases.quantity")->selectRaw('CONCAT(SUBSTRING(DAYNAME(orders.created_at), 1, 3), ", ", SUBSTRING(MONTHNAME(orders.created_at), 1, 3), " ", DAY(orders.created_at), ", ", YEAR(orders.created_at), " ", TIME_FORMAT(TIME(orders.created_at), "%h:%i:%s %p")) as datetime')->where("orders.id", $orderid)->get();
    }

    public function verify(Request $request)
    {
        $mobile  = $request->input("mobile");
        return User::where("type", "local")->where("phone_number", $mobile)->count();
    }

    public function register(Request $request)
    {
        $mobile  = $request->input("mobile");
        $firstname  = $request->input("firstname");
        $lastname  = $request->input("lastname");
        $password  = $request->input("password");
        $userid = User::create(["type" => "local", "firstname" => $firstname, "lastname" => $lastname, "phone_number" => $mobile, "password" => Hash::make($password)])->id;
        return User::select("id", "firstname", "lastname", "phone_number")->where('id', $userid)->get();
    }

    public function login(Request $request)
    {
        $mobile  = $request->input("mobile");
        $mypassword  = $request->input("password");
        $password = User::select("password")->where("type", "local")->where("phone_number", $mobile)->get();
        if (Hash::check($mypassword, $password[0]->password)) {
            return User::select("id", "firstname", "lastname", "phone_number")->where("type", "local")->where("phone_number", $mobile)->get();
        } else {
            return 0;
        }
    }

    public function address(Request $request)
    {
        $userid  = $request->input("userid");
        return Address::select("id", "street", "area", "note", "type", "latitude", "longitude")->where("user_id", $userid)->get();
    }

    public function address_detail(Request $request)
    {
        $addressid = $request->input("addressid");
        return Address::select("street", "area", "note", "type", "latitude", "longitude")->where("id", $addressid)->get();
    }

    public function address_create(Request $request)
    {
        $userid  = $request->input("userid");
        $street  = $request->input("street");
        $area  = $request->input("area");
        $note  = $request->input("note");
        $type  = $request->input("type");
        $lat  = $request->input("lat");
        $lng  = $request->input("lng");
        Address::create(["status_id" => 1, "user_id" => $userid, "street" => $street, "area" => $area, "note" => $note, "type" => $type, "latitude" => $lat, "longitude" => $lng]);
        return 1;
    }

    public function address_update(Request $request)
    {
        $addressid = $request->input("addressid");
        $street  = $request->input("street");
        $area  = $request->input("area");
        $note  = $request->input("note");
        $type  = $request->input("type");
        $lat  = $request->input("lat");
        $lng  = $request->input("lng");
        Address::where("id", $addressid)->update(["street" => $street, "area" => $area, "note" => $note, "type" => $type, "latitude" => $lat, "longitude" => $lng]);
        return 1;
    }

    public function address_delete(Request $request)
    {
        $addressid = $request->input("addressid");
        Address::where("id", $addressid)->delete();
        return 1;
    }

    public function address_select(Request $request)
    {
        $userid  = $request->input("userid");
        $addressid = $request->input("addressid");
        Address::where("id", $addressid)->update(["status_id" => 2]);
        Address::where("user_id", $userid)->where("id", "!=", $addressid)->update(["status_id" => 1]);
        return 1;
    }

    public function user(Request $request)
    {
        $userid  = $request->input("userid");
        return User::select("type", "firstname", "lastname", "phone_number")->where("id", $userid)->get();
    }

    public function user_update(Request $request)
    {
        $userid  = $request->input("userid");
        $firstname  = $request->input("firstname");
        $lastname  = $request->input("lastname");
        $password  = $request->input("password");
        User::where("id", $userid)->update(["firstname" => $firstname, "lastname" => $lastname, "password" => Hash::make($password)]);
        return 1;
    }

    public function send_code(Request $request)
    {
        $mobile  = $request->input("mobile");
        $code  = $request->input("code");
        return exec("cd C:\Users\REUEL\Downloads\Compressed\connect_device_package & python send_sms.py --endpoint=a2z88wegui0vm-ats.iot.ap-southeast-1.amazonaws.com --cert=certificate.pem.crt --key=private.pem.key --topic=sendsms --mobile=".$mobile." --code=".$code);
    }

    public function load_open_ticket(Request $request)
    {
        $userid  = $request->input("userid");
        return Ticket::where("user_id", $userid)->where("status_id", 1)->get();
    }

    public function submit_ticket(Request $request)
    {
        $ticketno = $request->input("ticketno");
        $title  = $request->input("title");
        $userid  = $request->input("userid");
        $ticketid = Ticket::create(["user_id" => $userid, "ticket_number" => $ticketno, "title" => $title, "status_id" => 1])->id;
        Chat::create(["ticket_id" => $ticketid, "user_id" => $userid, "message" => $title]);
        Chat::create(["ticket_id" => $ticketid, "message" => "Your message has been received, Please wait for our chat representative to assist you. Thank you!"]);
        return $ticketid;
    }

    public function load_chatbox(Request $request)
    {
        $ticketid = $request->input("ticketid");
        return Chat::join("tickets", "chats.ticket_id", "=","tickets.id")->select("tickets.ticket_number", "tickets.title", "tickets.status_id", "chats.user_id", "chats.message", "chats.created_at")->where("ticket_id", $ticketid)->get();
    }

    public function send_message(Request $request)
    {
        $ticketid = $request->input("ticketid");
        $userid  = $request->input("userid");
        $message = $request->input("message");
        Chat::create(["ticket_id" => $ticketid, "user_id" => $userid, "message" => $message]);
        return 1;
    }

    public function cancel_order(Request $request)
    {
        $orderid = $request->input("orderid");
        Order::where("id", $orderid)->update(["status_id" => 4]);
        Purchase::where("order_id", $orderid)->update(["status_id" => 2]);
        return 1;
    }

    public function re_oder(Request $request)
    {
        $orderid = $request->input("orderid");
        $order = Order::where("id", $orderid)->get();
        $purchase = Purchase::where("order_id", $orderid)->get();
        foreach ($purchase as $x) {
            Cart::create(["user_id" => $order[0]->user_id, "product_id" => $x->product_id, "selected_choices" => $x->selected_choices, "quantity" => $x->quantity, "instruction" => $x->instruction, "availability" => $x->availability]);
        }
        return 1;
    }

    public function update_forgot_password(Request $request)
    {
        $mobile = $request->input("mobile");
        $password = $request->input("password");
        User::where("type", "local")->where("phone_number", $mobile)->update(["password" => Hash::make($password)]);
        return User::select("id", "firstname", "lastname", "phone_number")->where("type", "local")->where("phone_number", $mobile)->get();
    }
}
