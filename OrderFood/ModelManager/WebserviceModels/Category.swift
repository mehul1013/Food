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

    internal var CategoryId:            Int = 0
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
    internal var Name:                  String = ""
    
    
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
        CategoryId          <- map["CategoryId"]
        CategoryName        <- map["CategoryName"]
        CategoryDescription <- map["CategoryDescription"]
        SeatId              <- map["SeatId"]
        SeatNo              <- map["SeatNo"]
        RowId               <- map["RowId"]
        RowName             <- map["RowName"]
        AudiId              <- map["AudiId"]
        AudiName            <- map["AudiName"]
        FoodStallId         <- map["FoodStallId"]
        FoodStallName       <- map["FoodStallName"]
        TheaterId           <- map["TheaterId"]
        Name                <- map["Name"]
    }
    
    
    //MARK: - Get Categories
    class func getcategories(strQRCode:String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        let strURL = WS_GET_CATEGORY + strQRCode
        
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
