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
    
    internal var itemname:  String = ""
    internal var itemprice: Double = 0.0
    internal var image:     String = ""
    internal var itemId:    Int = 0
    internal var categoryid:Int = 0
    internal var numberOfItem: Int = 0
    
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
        itemname    <- map["itemname"]
        itemprice   <- map["itemprice"]
        image       <- map["image"]
        itemId      <- map["itemId"]
        categoryid  <- map["categoryid"]
    }
    
    
    //MARK: - Get Categories
    class func searchItem(strSearch: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        let strURL = WS_SEARCH_ITEM + strSearch
        
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
