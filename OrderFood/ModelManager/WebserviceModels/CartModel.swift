//
//  CartModel.swift
//  OrderFood
//
//  Created by MehulS on 10/06/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper

class CartModel: Mappable {
    
    internal var GuestCartId    : Int = 0
    internal var NumberOfItem   : Int = 0
    internal var ItemID         : Int = 0
    internal var ItemName       : String = ""
    internal var ItemPrice      : Double = 0.0
    internal var Qty            : Int = 0
    internal var GuestCartItemDetailID  : Int = 0
    internal var Total          : Double = 0.0
    
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
        GuestCartId             <- map["GuestCartId"]
        NumberOfItem            <- map["NumberOfItem"]
        ItemID                  <- map["ItemID"]
        ItemName                <- map["ItemName"]
        ItemPrice               <- map["ItemPrice"]
        Qty                     <- map["Qty"]
        GuestCartItemDetailID   <- map["GuestCartItemDetailID"]
        Total                   <- map["Total"]
    }
    
    
    //MARK: - Get Cart
    class func getCart(showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let uuid = UIDevice.current.identifierForVendor
        
        //Make URL
        let strURL = WS_GET_CART_DETAIL + (uuid?.uuidString)!
        
        WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: nil) { (isSuccess, response, error) in
            if response?.data == nil {
                completionHandler(isSuccess, nil, error)
            }else {
                (response?.data as! [[String : Any]])
                let array = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                response?.formattedData = array as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Delete Cart Item
    class func deleteItemCart(itemID: Int, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let uuid = UIDevice.current.identifierForVendor
        
        //Make URL
        let strURL = WS_DELETE_CART + (uuid?.uuidString)! + "&ItemId=\(itemID)"
        
        WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: nil) { (isSuccess, response, error) in
            if response?.success == false {
                completionHandler(isSuccess, nil, error)
            }else {
                completionHandler(true, nil, error)
            }
        }
    }
    
    //MARK: - Create Cart
    class func createCart(arrayItems: NSMutableArray, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //GuestCartCreate
        let uuid = UIDevice.current.identifierForVendor
        let param1 : [String: AnyObject] = ["CustomerID"    : "0" as AnyObject,
                                            "GUID"          : uuid?.uuidString as AnyObject,
                                            "UserID"        : "0" as AnyObject]
        
        //GuestCartDetailCreate
        let param2 : [String: AnyObject] = ["NumberOfItem"  : "\(arrayItems.count)" as AnyObject,
                                            "ShowTimeId"    : "0" as AnyObject,
                                            "VenueId"       : "0" as AnyObject]
        
        //GuestCartItemDetailCreate
        
        //Final Dictionary
        let finalDict : [String: AnyObject] = ["GuestCartCreate"            : param1 as AnyObject,
                                               "GuestCartDetailCreate"      : param2 as AnyObject,
                                               "GuestCartItemDetailCreate"  : arrayItems as AnyObject]
        
        print("Dictionary : \(finalDict)")
        
        //Make URL
        let strURL = WS_CREATE_GUEST_CART
        
         WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: finalDict) { (isSuccess, response, error) in
            if response?.success == false {
                completionHandler(isSuccess, nil, error)
            }else {
                //print(response?.data as! [[String : Any]])
                //let array = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                //response?.formattedData = array as AnyObject?
                
                completionHandler(true, nil, error)
            }
         }
    }
}
