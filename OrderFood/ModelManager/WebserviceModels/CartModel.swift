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
    
    internal var itemname:  String = ""
    internal var itemprice: Double = 0.0
    internal var image:     String = ""
    internal var itemId:    Int = 0
    
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
        itemname    <- map["itemname"]
        itemprice   <- map["itemprice"]
        image       <- map["image"]
        itemId      <- map["itemId"]
    }
    
    
    //MARK: - Get Categories
    class func createCart(arrayItems: [[String: AnyObject]], showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //GuestCartCreate
        let uuid = UIDevice.current.identifierForVendor
        let param1 : [String: AnyObject] = ["CustomerID"    : "0" as AnyObject,
                                            "GUID"          : uuid as AnyObject,
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
        
        //Make URL
        let strURL = WS_CREATE_GUEST_CART
        
         WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: finalDict) { (isSuccess, response, error) in
            if response?.data == nil {
                completionHandler(isSuccess, nil, error)
            }else {
                print(response?.data as! [[String : Any]])
                let array = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                response?.formattedData = array as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
         }
    }
}
