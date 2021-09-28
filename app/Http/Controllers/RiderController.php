<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

use App\Models\Store;
use App\Models\Order;
use App\Models\Purchase;
use App\Models\Product;
use App\Models\Rider;
use App\Models\RiderOrder;
use App\Models\RiderRoom;
use App\Models\RiderSession;
use App\Models\Session;
use App\Models\Ticket;
use App\Models\Chat;

class RiderController extends Controller
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

    public function rider_login(Request $request)
    {
        $username = $request->input("username");
        $mypassword = $request->input("password");
        $rider = Rider::select("id", "firstname", "lastname", "password", "status_id")->where("username", $username)->get();
        if ($rider->isEmpty()) {
            return 0;
        } else {
            if (Hash::check($mypassword, $rider[0]->password)) {
                $checkridersession = RiderSession::where("rider_id", $rider[0]->id)->where("remitted", "")->get();
                $sessionrider = Session::whereRaw("CONCAT(DATE_FORMAT(NOW(), '%Y-%m-%d'), ' ', time_a) <= ?", [$checkridersession[0]->created_at])->whereRaw("CONCAT(DATE_FORMAT(NOW(), '%Y-%m-%d'), ' ', time_b) >= ?", [$checkridersession[0]->created_at])->get();
                $sessionnowid = Session::select("id")->where("time_a", "<=", date("H:i:s"))->where("time_b", ">=", date("H:i:s"))->get();
                if (count($checkridersession) == 0) {
                    Rider::where("username", $username)->update(["status_id" => 2]);
                    RiderSession::create(["session_id" => $sessionnowid[0]->id, "rider_id" => $rider[0]->id]);
                    return Rider::select("id", "firstname", "lastname", "status_id")->where("username", $username)->get();
                } else {
                    if (count($sessionrider) == 0) {

                    } else {

                    }
                    // if ($sessionnowid[0]->id == $checkridersession[0]->session_id) {
                        Rider::where("username", $username)->update(["status_id" => 2]);
                        return Rider::select("id", "firstname", "lastname", "status_id")->where("username", $username)->get();
                    // } else {
                        // if (count($sessionrider) == 0) {
                        //     Rider::where("username", $username)->update(["status_id" => 4]);
                        //     return Rider::select("id", "firstname", "lastname", "status_id")->where("username", $username)->get();
                        // } else {
                        //     Rider::where("username", $username)->update(["status_id" => 4]);
                        //     return Rider::select("id", "firstname", "lastname", "status_id")->where("username", $username)->get();
                        // }
                    // }
                }
            } else {
                return 0;
            }
        }
    }

    public function rider_logout(Request $request)
    {
        $riderid = $request->input("riderid");
        Rider::where("id", $riderid)->update(["status_id" => 1]);
        RiderRoom::where("rider_id", $riderid)->delete();
    }

    public function rider_active_delivery(Request $request)
    {
        $riderid = $request->input("riderid");
        return response()->json([
            "delivery" => RiderOrder::join("purchases","rider_orders.order_id","=","purchases.order_id")->join("orders","purchases.order_id","=","orders.id")->join("users","orders.user_id","=","users.id")->join("rider_order_status","rider_orders.status_id","=","rider_order_status.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("rider_orders.id as delivery_id", "rider_orders.order_id", "stores.id as store_id", "rider_order_status.name as rider_order_status", "orders.ship_from", "orders.ship_to", "orders.latitude as orderlat", "orders.longitude as orderlng", "orders.fare", "orders.token", "orders.note", "purchases.price", "purchases.selected_choices", "purchases.quantity", "stores.latitude as storelat", "stores.longitude as storelng", "users.firstname", "users.lastname", "users.phone_number")->selectRaw('CONCAT(SUBSTRING(DAYNAME(orders.created_at), 1, 3), ", ", SUBSTRING(MONTHNAME(orders.created_at), 1, 3), " ", DAY(orders.created_at), ", ", YEAR(orders.created_at), " ", TIME_FORMAT(TIME(orders.created_at), "%h:%i:%s %p")) as datetime')->where("rider_orders.rider_id", $riderid)->where(function($query){$query->where('rider_orders.status_id', "1")->orWhere('rider_orders.status_id', "2");})->get(),
            "rider" => Rider::select("id", "firstname", "lastname", "status_id")->where("id", $riderid)->get(),
        ]);
    }

    public function rider_accept_delivery(Request $request)
    {
        $deliveryid = $request->input("deliveryid");
        $riderid = $request->input("riderid");
        RiderOrder::where("id", $deliveryid)->update(["status_id" => 2]);
        Rider::where("id", $riderid)->update(["status_id" => 3]);
        return 1;
    }

    public function rider_decline_delivery(Request $request)
    {
        $deliveryid = $request->input("deliveryid");
        $storeid = $request->input("storeid");
        $orderid = $request->input("orderid");
        $riderid = $request->input("riderid");
        RiderOrder::where("id", $deliveryid)->update(["status_id" => 3]);
        $otherrider = RiderRoom::select("rider_id")->where("store_id", $storeid)->first();
        RiderOrder::create(["order_id" => $orderid, "rider_id" => $otherrider->rider_id, "status_id" => 1]);
        Rider::where("id", $otherrider->rider_id)->update(["status_id" => 3]);
        RiderRoom::where("rider_id", $otherrider->rider_id)->delete();
        Rider::where("id", $riderid)->update(["status_id" => 2]);
        return 1;
    }

    public function rider_complete_delivery(Request $request)
    {
        $deliveryid = $request->input("deliveryid");
        $orderid = $request->input("orderid");
        $riderid = $request->input("riderid");
        RiderOrder::where("id", $deliveryid)->update(["status_id" => 4]);
        Order::where("id", $orderid)->update(["status_id" => 5]);
        Rider::where("id", $riderid)->update(["status_id" => 2]);
        return 1;
    }

    public function rider_complete_orders(Request $request)
    {
        $riderid = $request->input("riderid");
        return response()->json([
            "complete" => RiderOrder::join("purchases","rider_orders.order_id","=","purchases.order_id")->join("orders","purchases.order_id","=","orders.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->where("rider_orders.rider_id", $riderid)->select("orders.id", "orders.token", "stores.orderbanner", "stores.name", "orders.fare", "purchases.price", "purchases.selected_choices", "purchases.quantity")->selectRaw('CONCAT(SUBSTRING(DAYNAME(rider_orders.updated_at), 1, 3), ", ", SUBSTRING(MONTHNAME(rider_orders.updated_at), 1, 3), " ", DAY(rider_orders.updated_at), ", ", YEAR(rider_orders.updated_at), " ", TIME_FORMAT(TIME(rider_orders.updated_at), "%h:%i:%s %p")) as datetime')->where("rider_orders.status_id", 4)->orderBy("rider_orders.updated_at", "desc")->get(),
            "decline" => RiderOrder::join("purchases","rider_orders.order_id","=","purchases.order_id")->join("orders","purchases.order_id","=","orders.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->where("rider_orders.rider_id", $riderid)->select("orders.id", "orders.token", "stores.orderbanner", "stores.name", "orders.fare", "purchases.price", "purchases.selected_choices", "purchases.quantity")->selectRaw('CONCAT(SUBSTRING(DAYNAME(rider_orders.updated_at), 1, 3), ", ", SUBSTRING(MONTHNAME(rider_orders.updated_at), 1, 3), " ", DAY(rider_orders.updated_at), ", ", YEAR(rider_orders.updated_at), " ", TIME_FORMAT(TIME(rider_orders.updated_at), "%h:%i:%s %p")) as datetime')->where("rider_orders.status_id", 3)->groupBy("rider_orders.order_id")->orderBy("rider_orders.updated_at", "desc")->get()
        ]);
    }

    public function rider_update_location(Request $request)
    {
        $riderid = $request->input("riderid");
        $lat = $request->input("lat");
        $lng = $request->input("lng");
        $riderstatus = Rider::where("id", $riderid)->where("status_id", 2)->get();
        if (count($riderstatus) == 1) {
            Rider::where("id", $riderid)->update(["latitude" => $lat, "longitude" => $lng]);
            $stores = Store::select("id", "latitude", "longitude")->where("status_id", 2)->get();
            foreach ($stores as $x) {
                $data = $this->LatLngToKM($lat, $lng, $x->latitude, $x->longitude);
                if($data <= 20) {
                    $exist = RiderRoom::where("rider_id", $riderid)->where("store_id", $x->id)->count();
                    if ($exist == 0) {
                        RiderRoom::create(["rider_id" => $riderid, "store_id" => $x->id]);
                    }
                } else {
                    RiderRoom::where("rider_id", $riderid)->delete();
                }
            }
            return 1;
        } else {
            return 0;
        }
    }

    public function rider_profile(Request $request)
    {
        $riderid = $request->input("riderid");
        return Rider::where("id", $riderid)->get();
    }

    public function rider_update_password(Request $request)
    {
        $riderid = $request->input("riderid");
        $password = $request->input("password");
        Rider::where("id", $riderid)->update(["password" => Hash::make($password)]);
        return 1;
    }
    public function rider_load_open_ticket(Request $request)
    {
        $riderid  = $request->input("riderid");
        return Ticket::where("rider_id", $riderid)->where("status_id", 1)->get();
    }

    public function rider_submit_ticket(Request $request)
    {
        $ticketno = $request->input("ticketno");
        $title  = $request->input("title");
        $riderid  = $request->input("riderid");
        $ticketid = Ticket::create(["rider_id" => $riderid, "ticket_number" => $ticketno, "title" => $title, "status_id" => 1])->id;
        Chat::create(["ticket_id" => $ticketid, "rider_id" => $riderid, "message" => $title]);
        Chat::create(["ticket_id" => $ticketid, "message" => "Your message has been received, Please wait for our chat representative to assist you. Thank you!"]);
        return $ticketid;
    }

    public function rider_load_chatbox(Request $request)
    {
        $ticketid = $request->input("ticketid");
        return Chat::join("tickets", "chats.ticket_id", "=","tickets.id")->select("tickets.ticket_number", "tickets.title", "tickets.status_id", "chats.rider_id", "chats.message", "chats.created_at")->where("ticket_id", $ticketid)->get();
    }

    public function rider_send_message(Request $request)
    {
        $ticketid = $request->input("ticketid");
        $riderid  = $request->input("riderid");
        $message = $request->input("message");
        Chat::create(["ticket_id" => $ticketid, "rider_id" => $riderid, "message" => $message]);
        return 1;
    }
}
