//
//  MyOrderInfo.swift
//  OrderFood
//
//  Created by MehulS on 18/08/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper


class MyOrderDeliveryInfo: Mappable {
    
    internal var venueName      : String = ""
    internal var theaterName    : String = ""
    internal var levelName      : String = ""
    internal var sectionName    : String = ""
    internal var rowName        : String = ""
    internal var seatName       : String = ""
    internal var totalAmount    : Double = 0.0
    internal var orderDate      : String = ""
    internal var itemAmount     : Double = 0.0
    internal var tax            : Double = 0.0
    
    init() {
    }
    
    class var mapperObj : Mapper<MyOrderDeliveryInfo>  {
        let mapper : Mapper = Mapper<MyOrderDeliveryInfo>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        venueName   <- map["venueName"]
        theaterName <- map["theaterName"]
        levelName   <- map["levelName"]
        sectionName <- map["sectionName"]
        rowName     <- map["rowName"]
        seatName    <- map["seatName"]
        totalAmount <- map["totalAmount"]
        orderDate   <- map["orderDate"]
        itemAmount  <- map["itemAmount"]
        tax         <- map["tax"]
    }
}


class MyOrderItemInfo: Mappable {
    
    internal var name   : String = ""
    internal var qty    : Int = 0
    internal var status : String = ""
    internal var rating : Double = 0.0
    internal var total  : Double = 0.0
    
    init() {
    }
    
    class var mapperObj : Mapper<MyOrderItemInfo>  {
        let mapper : Mapper = Mapper<MyOrderItemInfo>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        qty     <- map["qty"]
        status  <- map["status"]
        rating  <- map["rating"]
        total   <- map["total"]
    }
}


class MyOrderInfo: Mappable {
    
    var orderDesc : MyOrderDeliveryInfo!
    var itemArray : [MyOrderItemInfo]?
    
    init() {
    }
    
    class var mapperObj : Mapper<MyOrderInfo>  {
        let mapper : Mapper = Mapper<MyOrderInfo>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        do {
            let array : [String : Any] = try map.value("delivery")
            if array.count > 0 {
                orderDesc = MyOrderDeliveryInfo.mapperObj.map(JSON: array)
            }
        }catch {
            
        }
        
        do {
            let array : [[String : Any]] = try map.value("items")
            if array.count > 0 {
                itemArray = MyOrderItemInfo.mapperObj.mapArray(JSONArray: array)
            }
        }catch {
            
        }
    }
    
    
    //MARK: - Get Order Info
    class func getOrderInfo(strOrderID: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        var strURL = WS_ORDER_INFO + "\(strOrderID).json"
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(strURL)
        
        WebSerivceManager.GETRequest(url: strURL, showLoader: showLoader) { (isSuccess, response, error) in
            if isSuccess == false {
                completionHandler(isSuccess, nil, error)
            }else {
                let dictionary = self.mapperObj.map(JSON: response?.data as! [String : Any])
                response?.formattedData = dictionary as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
    }
}
