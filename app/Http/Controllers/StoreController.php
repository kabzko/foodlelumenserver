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
use App\Models\Ticket;
use App\Models\Chat;

class StoreController extends Controller
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

    public function store_login(Request $request)
    {
        $username = $request->input("username");
        $mypassword = $request->input("password");
        $password = Store::select("password")->where("username", $username)->get();
        if ($password->isEmpty()) {
            return 0;
        } else {
            if (Hash::check($mypassword, $password[0]->password)) {
                Store::where("username", $username)->update(["status_id" => 2]);
                return Store::select("id", "name", "latitude", "longitude")->where("username", $username)->get();
            } else {
                return 0;
            }
        }
    }

    public function store_logout(Request $request)
    {
        $storeid = $request->input("storeid");
        Store::where("id", $storeid)->update(["status_id" => 1]);
        RiderRoom::where("store_id", $storeid)->delete();
        return 1;
    }

    public function store_active_orders(Request $request)
    {
        $storeid = $request->input("storeid");
        return response()->json([
            "new" => Purchase::join("orders","purchases.order_id","=","orders.id")->join("order_status","orders.status_id","=","order_status.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("orders.id", "orders.delivery", "orders.when", "orders.token", "stores.orderbanner", "stores.name", "orders.fare", "purchases.price", "purchases.selected_choices", "purchases.quantity")->selectRaw('CONCAT(SUBSTRING(DAYNAME(orders.created_at), 1, 3), ", ", SUBSTRING(MONTHNAME(orders.created_at), 1, 3), " ", DAY(orders.created_at), ", ", YEAR(orders.created_at), " ", TIME_FORMAT(TIME(orders.created_at), "%h:%i:%s %p")) as datetime')->where("orders.status_id", "1")->where("products.store_id", $storeid)->orderBy("orders.created_at", "desc")->get(),
            "active" => Purchase::join("orders","purchases.order_id","=","orders.id")->join("order_status","orders.status_id","=","order_status.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("orders.id", "orders.delivery", "orders.when", "orders.token", "stores.orderbanner", "stores.name", "orders.fare", "purchases.price", "purchases.selected_choices", "purchases.quantity")->selectRaw('CONCAT(SUBSTRING(DAYNAME(orders.created_at), 1, 3), ", ", SUBSTRING(MONTHNAME(orders.created_at), 1, 3), " ", DAY(orders.created_at), ", ", YEAR(orders.created_at), " ", TIME_FORMAT(TIME(orders.created_at), "%h:%i:%s %p")) as datetime')->where("orders.status_id", "2")->where("products.store_id", $storeid)->orderBy("orders.created_at", "desc")->get(),
        ]);
    }

    public function store_order_detail(Request $request)
    {
        $orderid = $request->input("orderid");
        return response()->json([
            "order" => Purchase::join("orders","purchases.order_id","=","orders.id")->join("purchase_status","purchases.status_id","=","purchase_status.id")->join("payments","orders.payment_id","=","payments.id")->join("users","orders.user_id","=","users.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->join("order_status","orders.status_id","=","order_status.id")->select("orders.fare", "orders.when", "payments.type", "orders.id", "order_status.name as order_status", "orders.token", "products.name", "purchases.id as item_id", "purchases.price", "purchases.selected_choices", "purchases.quantity", "purchases.instruction", "purchases.availability", "purchases.status_id", "users.firstname", "users.lastname", "users.phone_number")->selectRaw('CONCAT(SUBSTRING(DAYNAME(orders.created_at), 1, 3), ", ", SUBSTRING(MONTHNAME(orders.created_at), 1, 3), " ", DAY(orders.created_at), ", ", YEAR(orders.created_at), " ", TIME_FORMAT(TIME(orders.created_at), "%h:%i:%s %p")) as datetime')->where("orders.id", $orderid)->get(),
            "rider" => RiderOrder::join("riders","rider_orders.rider_id","=","riders.id")->join("rider_order_status","rider_orders.status_id","=","rider_order_status.id")->select("rider_orders.id", "rider_orders.rider_id", "riders.firstname", "riders.lastname", "rider_order_status.name", "riders.rider_code")->where("rider_orders.order_id", $orderid)->where("rider_orders.status_id","!=","3")->get()
        ]);
    }

    public function store_order_cancel(Request $request)
    {
        $orderid = $request->input("orderid");
        Order::where("id", $orderid)->update(["status_id" => 4]);
        return 1;
    }

    public function store_order_accept(Request $request)
    {
        $index = 0;
        $riderlist = [];
        $storelat = $request->input("storelat");
        $storelng = $request->input("storelng");
        $storeid = $request->input("storeid");
        $orderid = $request->input("orderid");
        $ridersroom = RiderRoom::join("riders", "rider_rooms.rider_id", "=", "riders.id")->select("riders.id", "riders.latitude", "riders.longitude")->where("rider_rooms.store_id", $storeid)->get();
        foreach ($ridersroom as $x) {
            $data = $this->LatLngToKM($storelat, $storelng, $x->latitude, $x->longitude);
            array_push($riderlist, ["id" => $x->id, "distance" => $data]);
        }
        $distance = array_column($riderlist, "distance");
        array_multisort($distance, SORT_ASC, $riderlist);
        if ($ridersroom->isEmpty()) {
            return 0;
        } else {
            foreach ($riderlist as $x) {
                $index++;
                $riderstatus = RiderOrder::where("order_id", $orderid)->where("rider_id", $x["id"])->count();
                if ($riderstatus == 0) {
                    RiderOrder::create(["order_id" => $orderid, "rider_id" => $x["id"], "status_id" => 1]);
                    Rider::where("id", $x["id"])->update(["status_id" => 3]);
                    RiderRoom::where("rider_id", $x["id"])->delete();
                    Order::where("id", $orderid)->update(["status_id" => 2]);
                    return 1;
                    break;
                } else {
                    if (count($riderlist) == $index) {
                        return 0;
                    }
                }
            }
        }
    }

    public function store_change_rider(Request $request)
    {
        $index = 0;
        $riderlist = [];
        $deliveryid = $request->input("deliveryid");
        $storeid = $request->input("storeid");
        $orderid = $request->input("orderid");
        $riderid = $request->input("riderid");
        $storelat = $request->input("storelat");
        $storelng = $request->input("storelng");
        RiderOrder::where("id", $deliveryid)->update(["status_id" => 3]);
        $ridersroom = RiderRoom::join("riders", "rider_rooms.rider_id", "=", "riders.id")->select("riders.id", "riders.latitude", "riders.longitude")->where("rider_rooms.store_id", $storeid)->get();
        foreach ($ridersroom as $x) {
            $data = $this->LatLngToKM($storelat, $storelng, $x->latitude, $x->longitude);
            array_push($riderlist, ["id" => $x->id, "distance" => $data]);
        }
        $distance = array_column($riderlist, "distance");
        array_multisort($distance, SORT_ASC, $riderlist);
        if ($ridersroom->isEmpty()) {
            Rider::where("id", $riderid)->update(["status_id" => 2]);
            Order::where("id", $orderid)->update(["status_id" => 1]);
            return 0;
        } else {
            foreach ($riderlist as $x) {
                $index++;
                $riderstatus = RiderOrder::where("order_id", $orderid)->where("rider_id", $x->rider_id)->count();
                if ($riderstatus == 0) {
                    RiderOrder::create(["order_id" => $orderid, "rider_id" => $x->rider_id, "status_id" => 1]);
                    Rider::where("id", $x->rider_id)->update(["status_id" => 3]);
                    RiderRoom::where("rider_id", $x->rider_id)->delete();
                    Rider::where("id", $riderid)->update(["status_id" => 2]);
                    return 1;
                    break;
                } else {
                    if (count($riderlist) == $index) {
                        return 0;
                    }
                }
            }
        }
    }

    public function store_item_detail(Request $request)
    {
        $itemid = $request->input("itemid");
        return Purchase::join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("products.name", "purchases.price", "purchases.selected_choices","purchases.quantity")->where("purchases.id", $itemid)->get();
    }

    public function store_item_remove(Request $request)
    {
        $cart = $request->input("cart");
        $orderid = $request->input("orderid");
        $itemid = $request->input("itemid");
        if ($cart > 1) {
            Purchase::where("id", $itemid)->update(["status_id" => 2]);
            return 0;
        } else {
            Order::where("id", $orderid)->update(["status_id" => 4]);
            Purchase::where("id", $itemid)->update(["status_id" => 2]);
            return 1;
        }
    }

    public function store_item_update(Request $request)
    {
        $itemid = $request->input("itemid");
        $choices = $request->input("choices");
        $quantity = $request->input("quantity");
        Purchase::where("id", $itemid)->update(["selected_choices" => $choices, "quantity" => $quantity, "status_id" => 1]);
        return 1;
    }

    public function store_store_detail(Request $request)
    {
        $storeid = $request->input("storeid");
        return response()->json([
            "products" => Product::select("id", "name", "price", "category", "store_id")->where("store_id", $storeid)->get(),
            "category" => Product::select("id", "category")->where("store_id", $storeid)->groupBy("category")->get(),
        ]);
    }

    public function store_add_order(Request $request)
    {
        $orderid = $request->input("orderid");
        $productid = $request->input("productid");
        $price = $request->input("price");
        $choices = $request->input("choices");
        $quantity = $request->input("quantity");
        $availability = $request->input("availability");
        $instruction = $request->input("instruction");
        Purchase::create(["order_id" => $orderid, "product_id" => $productid, "price" => $price, "selected_choices" => $choices, "quantity" => $quantity, "instruction" => $instruction, "availability" => $availability]);
        return 1;
    }

    public function store_past_orders(Request $request)
    {
        $storeid = $request->input("storeid");
        return Purchase::join("orders","purchases.order_id","=","orders.id")->join("order_status","orders.status_id","=","order_status.id")->join("products","purchases.product_id","=","products.id")->join("stores","products.store_id","=","stores.id")->select("orders.id", "orders.token", "stores.orderbanner", "orders.when", "stores.name", "orders.fare", "purchases.price", "purchases.selected_choices", "purchases.quantity")->selectRaw('CONCAT(SUBSTRING(DAYNAME(orders.created_at), 1, 3), ", ", SUBSTRING(MONTHNAME(orders.created_at), 1, 3), " ", DAY(orders.created_at), ", ", YEAR(orders.created_at), " ", TIME_FORMAT(TIME(orders.created_at), "%h:%i:%s %p")) as datetime')->where(function($query){$query->where('orders.status_id', "3")->orWhere('orders.status_id', "4");})->where("products.store_id", $storeid)->orderBy("orders.created_at", "desc")->get();
    }

    public function store_products(Request $request)
    {
        $storeid = $request->input("storeid");
        return Product::where("store_id", $storeid)->orderBy("created_at", "desc")->get();
    }

    public function store_category(Request $request)
    {
        $storeid = $request->input("storeid");
        return Product::select("category")->where("store_id", $storeid)->groupBy("category")->get();
    }

    public function store_save_new_product(Request $request)
    {
        $name = $request->input("name");
        $price = $request->input("price");
        $description = $request->input("description");
        $choices = $request->input("choices");
        $category = $request->input("category");
        $image = $request->file("image");
        $storeid = $request->input("storeid");
        $imagename = $name.".".$image->getClientOriginalExtension();
        $path = "C:/xampp/htdocs/foodleimages/product_image/";
        $image->move($path, $imagename);
        $imageurl = "http://localhost/foodleimages/product_image/".$imagename;
        Product::create(["name" => $name, "price" => $price, "description" => $description, "choices" => $choices, "category" => $category, "image" => $imageurl, "store_id" => $storeid]);
        return 1;
    }

    public function store_search_products(Request $request)
    {
        $search = $request->input("search");
        $storeid = $request->input("storeid");
        return Product::select("id", "name", "price", "store_id", "image")->where("store_id", $storeid)->where("name", "like", "%".$search."%")->get();
    }

    public function store_product_detail(Request $request)
    {
        $productid = $request->input("productid");
        $storeid = $request->input("storeid");
        return response()->json([
            "product" => Product::select("name", "price", "description", "choices", "image", "category")->where("id", $productid)->get(),
            "category" => Product::select("category")->where("store_id", $storeid)->groupBy("category")->get(),
        ]);
    }

    public function store_update_product(Request $request)
    {
        $name = $request->input("name");
        $price = $request->input("price");
        $description = $request->input("description");
        $choices = $request->input("choices");
        $category = $request->input("category");
        $image = $request->file("image");
        $storeid = $request->input("storeid");
        $productid = $request->input("productid");
        if ($image != null) {
            $imagename = $name.".".$image->getClientOriginalExtension();
            $path = "C:/xampp/htdocs/foodleimages/product_image/";
            $image->move($path, $imagename);
            $imageurl = "http://localhost/foodleimages/product_image/".$imagename;
            Product::where("id", $productid)->update(["name" => $name, "price" => $price, "description" => $description, "choices" => $choices, "category" => $category, "image" => $imageurl]);
            return 1;
        } else {
            Product::where("id", $productid)->update(["name" => $name, "price" => $price, "description" => $description, "choices" => $choices, "category" => $category]);
            return 1;
        }
    }

    public function store_enable_product(Request $request)
    {
        $productid = $request->input("productid");
        Product::where("id", $productid)->update(["status_id" => 1]);
        return 1;
    }

    public function store_disable_product(Request $request)
    {
        $productid = $request->input("productid");
        $storeid = $request->input("storeid");
        $checkactive = Product::where("store_id", $storeid)->where("status_id", 1)->count();
        if ($checkactive >= 2) {
            Product::where("id", $productid)->update(["status_id" => 2]);
            return 1;
        } else {
            return 0;
        }
    }

    public function store_profile(Request $request)
    {
        $storeid = $request->input("storeid");
        return Store::where("id", $storeid)->get();
    }

    public function store_load_open_ticket(Request $request)
    {
        $storeid  = $request->input("storeid");
        return Ticket::where("store_id", $storeid)->where("status_id", 1)->get();
    }

    public function store_submit_ticket(Request $request)
    {
        $ticketno = $request->input("ticketno");
        $title  = $request->input("title");
        $storeid  = $request->input("storeid");
        $ticketid = Ticket::create(["store_id" => $storeid, "ticket_number" => $ticketno, "title" => $title, "status_id" => 1])->id;
        Chat::create(["ticket_id" => $ticketid, "store_id" => $storeid, "message" => $title]);
        Chat::create(["ticket_id" => $ticketid, "message" => "Your message has been received, Please wait for our chat representative to assist you. Thank you!"]);
        return $ticketid;
    }

    public function store_load_chatbox(Request $request)
    {
        $ticketid = $request->input("ticketid");
        return Chat::join("tickets", "chats.ticket_id", "=","tickets.id")->select("tickets.ticket_number", "tickets.title", "tickets.status_id", "chats.store_id", "chats.message", "chats.created_at")->where("ticket_id", $ticketid)->get();
    }

    public function store_send_message(Request $request)
    {
        $ticketid = $request->input("ticketid");
        $storeid  = $request->input("storeid");
        $message = $request->input("message");
        Chat::create(["ticket_id" => $ticketid, "store_id" => $storeid, "message" => $message]);
        return 1;
    }

    public function store_update_password(Request $request)
    {
        $storeid  = $request->input("storeid");
        $password = $request->input("password");
        Store::where("id", $storeid)->update(["password" => Hash::make($password)]);
        return 1;
    }
}
