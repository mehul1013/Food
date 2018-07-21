//
//  Item.swift
//  OrderFood
//
//  Created by Mehul Solanki on 01/06/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper

class Item: Mappable {

    /*internal var FoodItemId:    Int = 0
    internal var FoodItemName:  String = ""
    internal var FoodItemDesc:  String = ""
    internal var Amount:        Double = 0.0
    internal var TaxAmount:     Int = 0
    internal var CategoryId:    Int = 0
    internal var Image:         String = ""
    internal var IsVeg:         Int = 0
    internal var numberOfItem:  Int = 0*/
    
    internal var id:            Int = 0
    internal var name:          String = ""
    internal var categoryId:    Int = 0
    internal var maxTopings:    Int = 0
    internal var isVeg:         Int = 0
    internal var description:   String = ""
    internal var image:         String = ""
    internal var amount:        Double = 0.0
    internal var numberOfItem:  Int = 0
    
    
    init() {
    }
    
    class var mapperObj : Mapper<Item>  {
        let mapper : Mapper = Mapper<Item>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        categoryId  <- map["categoryId"]
        maxTopings  <- map["maxTopings"]
        isVeg       <- map["isVeg"]
        description <- map["description"]
        image       <- map["image"]
        amount      <- map["amount"]
    }
    
    
    //MARK: - Get Categories
    class func getItemForCategory(strCategoryID: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        let strURL = WS_GET_ITEM + "\(strCategoryID).json"
        
        WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: nil) { (isSuccess, response, error) in
            
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
