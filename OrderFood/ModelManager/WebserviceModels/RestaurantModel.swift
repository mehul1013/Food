//
//  RestaurantModel.swift
//  OrderFood
//
//  Created by MehulS on 15/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper


class offerList: Mappable {
    internal var kitchenId      : Int = 0
    internal var discountId     : Int = 0
    internal var discountCode   : String = ""
    internal var minOrderAmount : Int = 0
    internal var discountValue  : String = ""
    internal var expiresOn      : String = ""
    
    init() {
        
    }
    
    class var mapperObj : Mapper<offerList>  {
        let mapper : Mapper = Mapper<offerList>()
        return mapper
    }
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        kitchenId       <- map["kitchenId"]
        discountId      <- map["discountId"]
        discountCode    <- map["discountCode"]
        minOrderAmount  <- map["minOrderAmount"]
        discountValue   <- map["discountValue"]
        expiresOn       <- map["expiresOn"]
    }
}

class RestaurantModel: Mappable {
    
    internal var kitchenId  : Int = 0
    internal var venueId    : Int = 0
    internal var avgCost    : Int = 0
    
    internal var name       : String = ""
    internal var email      : String = ""
    internal var imageUrl   : String = ""
    internal var contact    : String = ""
    internal var offer      : String = ""
    
    var cuisineArray : String = ""
    var offerArray : [offerList]?
    
    init() {
    }
    
    class var mapperObj : Mapper<RestaurantModel>  {
        let mapper : Mapper = Mapper<RestaurantModel>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        kitchenId   <- map["kitchenId"]
        venueId     <- map["venueId"]
        avgCost     <- map["avgCost"]
        
        name        <- map["name"]
        email       <- map["email"]
        imageUrl    <- map["imageUrl"]
        contact     <- map["contact"]
        offer       <- map["offer"]
        
        do {
            let array : [String] = try map.value("cuisines")
            if array.count > 0 {
                cuisineArray = array.joined(separator: ", ")
            }
        }catch {
            
        }
        
        do {
            let array : [[String : Any]] = try map.value("offerList")
            if array.count > 0 {
                offerArray = offerList.mapperObj.mapArray(JSONArray: array)
            }
        }catch {
            
        }
    }
    
    //MARK: - Get Cart
    class func getRestaurants(strVenueID: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        let strURL = WS_GET_RESTAURANT + strVenueID + ".json"
        print(strURL)
        
        WebSerivceManager.GETRequest(url: strURL, showLoader: showLoader) { (isSuccess, response, error) in
            if response?.data == nil {
                completionHandler(isSuccess, nil, error)
            }else {
                let dictionary = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                response?.formattedData = dictionary as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
    }
}
