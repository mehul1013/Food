//
//  VersionControl.swift
//  controlcast
//
//  Created by Mehul Solanki on 14/12/17.
//  Copyright © 2017 Openxcell Game. All rights reserved.
//

import UIKit
import ObjectMapper

class Category: Mappable {

    /*internal var CategoryId:            Int = 0
    internal var CategoryName:          String = ""
    internal var CategoryDescription:   String = ""
    internal var SeatId:                String = ""
    internal var SeatNo:                String = ""
    internal var RowId:                 String = ""
    internal var RowName:               String = ""
    internal var AudiId:                String = ""
    internal var AudiName:              String = ""
    internal var FoodStallId:           String = ""
    internal var FoodStallName:         String = ""
    internal var TheaterId:             String = ""
    internal var Name:                  String = ""*/
    
    internal var id:            Int = 0
    internal var name:          String = ""
    internal var kitchenId:     Int = 0
    internal var kitchenName:   String = ""
    internal var description:   String = ""
    
    
    init() {
    }
    
    class var mapperObj : Mapper<Category>  {
        let mapper : Mapper = Mapper<Category>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        kitchenId   <- map["kitchenId"]
        kitchenName <- map["kitchenName"]
        description <- map["description"]
    }
    
    
    //MARK: - Get Categories
    class func getcategories(strVenueID: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        let strURL = WS_GET_CATEGORY + "\(strVenueID).json"
        
        WebSerivceManager.GETRequest(url: strURL, showLoader: showLoader) { (isSuccess, response, error) in
            if isSuccess == false {
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
