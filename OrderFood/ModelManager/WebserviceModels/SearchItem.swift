//
//  Search.swift
//  OrderFood
//
//  Created by MehulS on 03/06/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper

class SearchItem: Mappable {
    
    internal var id:            Int = 0
    internal var name:          String = ""
    internal var categoryId:    Int = 0
    internal var kitchenId:     Int = 0
    internal var itemPriceId:   Int = 0
    internal var maxTopings:    Int = 0
    internal var isVeg:         Int = 0
    internal var description:   String = ""
    internal var image:         String = ""
    internal var amount:        Double = 0.0
    internal var numberOfItem:  Int = 0
    
    
    init() {
    }
    
    class var mapperObj : Mapper<SearchItem>  {
        let mapper : Mapper = Mapper<SearchItem>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        categoryId  <- map["categoryId"]
        kitchenId   <- map["kitchenId"]
        itemPriceId <- map["itemPriceId"]
        maxTopings  <- map["maxTopings"]
        isVeg       <- map["isVeg"]
        description <- map["description"]
        image       <- map["image"]
        amount      <- map["amount"]
    }
    
    
    //MARK: - Get Categories
    class func searchItem(strKitchenID: String, strSearch: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        let strURL = WS_SEARCH_ITEM + "\(strSearch)\\\(strKitchenID).json"
        
        WebSerivceManager.GETRequest(url: strURL, showLoader: showLoader) { (isSuccess, response, error) in
            if response?.data == nil {
                completionHandler(isSuccess, nil, error)
            }else {
                print(response?.data as! [[String : Any]])
                let array = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                response?.formattedData = array as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
        
        /*
        WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: nil) { (isSuccess, response, error) in
        }*/
    }
}
