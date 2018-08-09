//
//  MyOrderModel.swift
//  OrderFood
//
//  Created by MehulS on 08/08/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper

class MyOrderModel: Mappable {
    
    internal var id             : String = ""
    internal var orderNumber    : Int = 0
    internal var kitchenId      : Int = 0
    internal var orderStatus    : String = ""
    internal var rating         : Int = 0
    internal var itemAmount     : Double = 0.0
    internal var tax            : Double = 0.0
    internal var totalAmount    : Double = 0.0
    internal var orderDate      : String = ""
    internal var kitchenName    : String = ""
    internal var discount       : Double = 0.0
    internal var kitchenLogo    : String = ""
    internal var rowName        : String = ""
    internal var seatName       : String = ""
    
    init() {
    }
    
    class var mapperObj : Mapper<MyOrderModel>  {
        let mapper : Mapper = Mapper<MyOrderModel>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        orderNumber     <- map["orderNumber"]
        kitchenId       <- map["kitchenId"]
        orderStatus     <- map["orderStatus"]
        rating          <- map["rating"]
        itemAmount      <- map["itemAmount"]
        tax             <- map["tax"]
        totalAmount     <- map["totalAmount"]
        orderDate       <- map["orderDate"]
        kitchenName     <- map["kitchenName"]
        discount        <- map["discount"]
        kitchenLogo     <- map["kitchenLogo"]
        rowName         <- map["rowName"]
        seatName        <- map["seatName"]
    }
    
    
    //MARK: - Get Current Orders
    class func getCurrentOrders(strVenueID: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        var strURL = WS_CURRENT_ORDER + "\(strVenueID)/current.json"
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(strURL)
        
        WebSerivceManager.GETRequest(url: strURL, showLoader: showLoader) { (isSuccess, response, error) in
            if isSuccess == false {
                completionHandler(isSuccess, nil, error)
            }else {
                let dictionary = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                response?.formattedData = dictionary as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    //MARK: - Get Past Orders
    class func getPastOrders(strVenueID: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        var strURL = WS_CURRENT_ORDER + "\(strVenueID)/past.json"
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(strURL)
        
        WebSerivceManager.GETRequest(url: strURL, showLoader: showLoader) { (isSuccess, response, error) in
            if isSuccess == false {
                completionHandler(isSuccess, nil, error)
            }else {
                let dictionary = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                response?.formattedData = dictionary as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
    }
}
