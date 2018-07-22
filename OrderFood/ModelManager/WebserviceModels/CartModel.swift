//
//  CartModel.swift
//  OrderFood
//
//  Created by MehulS on 10/06/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper


class cartDict: Mappable {
    internal var id         : Int = 0
    internal var guid       : String = ""
    internal var customerId : Int = 0
    internal var discountId : Int = 0
    internal var userId     : Int = 0
    internal var subTotal   : Double = 0.0
    internal var tax        : Double = 0.0
    internal var total      : Double = 0.0
    internal var ipAddress  : Int = 0
    
    init() {}
    
    class var mapperObj : Mapper<cartDict>  {
        let mapper : Mapper = Mapper<cartDict>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        guid        <- map["guid"]
        customerId  <- map["customerId"]
        discountId  <- map["discountId"]
        userId      <- map["userId"]
        subTotal    <- map["subTotal"]
        tax         <- map["tax"]
        total       <- map["total"]
        ipAddress   <- map["ipAddress"]
    }
}


class cartDeliveryDict: Mappable {
    internal var kitchenId  : Int = 0
    internal var venueId    : Int = 0
    internal var theaterId  : Int = 0
    internal var levelId    : Int = 0
    internal var sectionId  : Int = 0
    internal var rowId      : Int = 0
    internal var seatId     : Int = 0
    
    internal var restaurantName : String = ""
    internal var restaurantImage : String = ""
    
    init() {}
    
    class var mapperObj : Mapper<cartDeliveryDict>  {
        let mapper : Mapper = Mapper<cartDeliveryDict>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        kitchenId   <- map["kitchenId"]
        venueId     <- map["venueId"]
        theaterId   <- map["theaterId"]
        levelId     <- map["levelId"]
        sectionId   <- map["sectionId"]
        rowId       <- map["rowId"]
        seatId      <- map["seatId"]
    }
}

class cartItemsArray: Mappable {
    internal var itemId         : Int = 0
    internal var itemName       : String = ""
    internal var itemPrice      : Double = 0.0
    internal var itemTax        : Double = 0.0
    internal var subTotal       : Double = 0.0
    internal var tax            : Double = 0.0
    internal var total          : Double = 0.0
    internal var qty            : Int = 0
    
    init() {}
    
    class var mapperObj : Mapper<cartItemsArray>  {
        let mapper : Mapper = Mapper<cartItemsArray>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        itemId                  <- map["itemId"]
        itemName                <- map["itemName"]
        itemPrice               <- map["itemPrice"]
        itemTax                 <- map["itemTax"]
        subTotal                <- map["subTotal"]
        tax                     <- map["tax"]
        total                   <- map["total"]
        qty                     <- map["qty"]
    }
}



class CartModel: Mappable {
    
    //internal var GuestCartId    : Int = 0
    //internal var NumberOfItem   : Int = 0
    
    
    var cartItems : [cartItemsArray]?
    var cart : cartDict?
    var cartDelivery : cartDeliveryDict?
    
    //internal var GuestCartItemDetailID  : Int = 0
    
    
    init() {
    }
    
    class var mapperObj : Mapper<CartModel>  {
        let mapper : Mapper = Mapper<CartModel>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        do {
            let array : [[String : Any]] = try map.value("cartItems")
            if array.count > 0 {
                cartItems = cartItemsArray.mapperObj.mapArray(JSONArray: array)
            }
        }catch {
            
        }
        
        do {
            let array : [String : Any] = try map.value("cart")
            if array.count > 0 {
                cart = cartDict.mapperObj.map(JSON: array)
            }
        }catch {
            
        }
        
        do {
            let array : [String : Any] = try map.value("cartDelivery")
            if array.count > 0 {
                cartDelivery = cartDeliveryDict.mapperObj.map(JSON: array)
            }
        }catch {
            
        }
    }
    
    
    //MARK: - Get Cart
    class func getCart(showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let guid = AppUtils.APPDELEGATE().guid
        
        //Make URL
        var strURL = WS_GET_CART_DETAIL + "\(guid).json"
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        WebSerivceManager.GETRequest(url: strURL, showLoader: showLoader) { (isSuccess, response, error) in
            if isSuccess == false {
                completionHandler(isSuccess, nil, error)
            }else {
                //let array = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                let dictionary = self.mapperObj.map(JSON: response?.data as! [String : Any])
                response?.formattedData = dictionary as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
        
        /*
        WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: nil) { (isSuccess, response, error) in
            
        }*/
    }
    
    
    //MARK: - Delete Cart Item
    class func deleteItemCart(itemID: Int, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let uuid = AppUtils.APPDELEGATE().guid
        
        //Make URL
        let strURL = WS_DELETE_CART + "\(uuid)/\(itemID).json"
        
        WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: nil) { (isSuccess, response, error) in
            if response?.success == 1 {
                completionHandler(isSuccess, nil, error)
            }else {
                completionHandler(true, nil, error)
            }
        }
    }
    
    //MARK: - Create Cart
    class func createCart(arrayItems: NSMutableArray, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //GuestCartCreate
        var uuid = AppUtils.APPDELEGATE().guid
        if uuid == "" {
            uuid = ""
        }
        
        let param1 : [String: AnyObject] = ["GuId"          : uuid as AnyObject,
                                            "customerId"    : "0" as AnyObject,
                                            "discountId"    : "0" as AnyObject,
                                            "ipAddress"     : "0" as AnyObject,
                                            "userId"        : "0" as AnyObject]
        
        //GuestCartDetailCreate
        let param2 : [String: AnyObject] = ["GuId"          : uuid as AnyObject,
                                            "kitchenId"     : AppUtils.APPDELEGATE().CartDeliveryModel.kitchenId as AnyObject,
                                            "levelId"       : AppUtils.APPDELEGATE().CartDeliveryModel.levelId as AnyObject,
                                            "rowId"         : AppUtils.APPDELEGATE().CartDeliveryModel.rowId as AnyObject,
                                            "seatId"        : AppUtils.APPDELEGATE().CartDeliveryModel.seatId as AnyObject,
                                            "sectionId"     : AppUtils.APPDELEGATE().CartDeliveryModel.sectionId as AnyObject,
                                            "theaterId"     : AppUtils.APPDELEGATE().CartDeliveryModel.theaterId as AnyObject,
                                            "venueId"       : AppUtils.APPDELEGATE().CartDeliveryModel.venueId as AnyObject]
        
        //GuestCartItemDetailCreate
        
        //Final Dictionary
        let finalDict : [String: AnyObject] = ["GuestCart"            : param1 as AnyObject,
                                               "GuestCartDelivery"    : param2 as AnyObject,
                                               "GuestCartItems"       : arrayItems as AnyObject]
        
        print("Dictionary : \(finalDict)")
        
        //Make URL
        let strURL = WS_CREATE_GUEST_CART
        
         WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: finalDict) { (isSuccess, response, error) in
            if response?.success == 0 {
                completionHandler(isSuccess, nil, error)
            }else {
                //print(response?.data as! [[String : Any]])
                //let array = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                //response?.formattedData = array as AnyObject?
                
                completionHandler(true, response, error)
            }
         }
    }
}
