//
//  WebserviceRootModel.swift
//  controlcast
//
//  Created by Hiren Gujarati on 16/02/17.
//  Copyright © 2017 Openxcell Game. All rights reserved.
//

import UIKit
import ObjectMapper

class WebServiceReponse : Mappable {
    
    internal var status : Int?
    internal var message : String?
    internal var data: AnyObject?
    internal var key : String?
    //internal var success : Bool?
    internal var success : Int?
    internal var isMore : Bool?
    internal var formattedData: AnyObject?
    internal var iCastID : String?
    internal var total   : String?
    internal var totalApprov   : String = "0"
    internal var totalPending  : String = "0"
    
    internal var Errors : String?
    internal var AggregateResults : String?
    internal var Total : String?
    internal var GrandTotal : Int?
    internal var Count : Int?
   
    
    init() {
        
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    class var mapperObj : Mapper<WebServiceReponse>  {
        let mapper : Mapper = Mapper<WebServiceReponse>()
        return mapper
    }
    
    func mapping(map: Map) {
        Errors <- map["Errors"]
        AggregateResults <- map["AggregateResults"]
        Total <- map["Total"]
        
        GrandTotal <- map["Total"]
        Count <- map["Total"]
        
        status <- map["STATUS"]
        message <- map["MESSAGE"]
        //data <- map["DATA"]
        data <- map["data"]
        key <- map["key"]
        
        //iCastID
        iCastID <- map["iCastID"]
        
        //total
        total <- map["total"]
        totalApprov  <- map["totalApprov"]
        totalPending <- map["totalPending"]
        
        success <- map["success"]
        
        /*do {
            if try map.value("success") == 1 {
                success = true
            }else {
                success = false
            }
        }catch {
            success = false
        }*/
        
        
        do {
            if try map.value("isMore") == 1 {
                isMore = true
            }else {
                isMore = false
            }
        }catch {
            isMore = false
        }
    }
}
