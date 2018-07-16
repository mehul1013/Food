 //
//  CityModel.swift
//  controlcast
//
//  Created by iPhone-4 on 16/02/17.
//  Copyright © 2017 Openxcell Game. All rights reserved.
//

import UIKit
import ObjectMapper

class CityModel: Mappable {
    internal var cityId:String = ""
    internal var cityName:String = ""
    
    init() {
    }

    class var mapperObj : Mapper<CityModel>  {
        let mapper : Mapper = Mapper<CityModel>()
        return mapper
    }
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        cityId <- map["iCityID"]
        cityName <- map["vCity"]
    }

    class func getCityList(countryId:String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["iCountry":countryId as AnyObject]

        WebSerivceManager.POSTRequest(url: "", showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == 1 {
                    let array = self.mapperObj.mapArray(JSONArray: (response?.data)! as! [[String : Any]])
                    response?.formattedData = array as AnyObject?
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, nil, error)
            }
        }
    }
}


class AreaModel: Mappable {
    internal var iAreaID:   String = ""
    internal var vAreaName: String = ""
    
    init() {
        
    }
    
    class var mapperObj : Mapper<AreaModel>  {
        let mapper : Mapper = Mapper<AreaModel>()
        return mapper
    }
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        iAreaID     <- map["iAreaID"]
        vAreaName   <- map["vAreaName"]
    }
    
    class func getAreaList(cityId:   String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["iCityID": cityId as AnyObject]
        
        WebSerivceManager.POSTRequest(url: "", showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == 1 {
                    let array = self.mapperObj.mapArray(JSONArray: (response?.data)! as! [[String : Any]])
                    response?.formattedData = array as AnyObject?
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, nil, error)
            }
        }
    }
}


