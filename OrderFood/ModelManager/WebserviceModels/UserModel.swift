//
//  UserModel.swift
//  OrderFood
//
//  Created by Bhavik on 17/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModel: Mappable {
    init() {
    }
    
    class var mapperObj : Mapper<UserModel>  {
        let mapper : Mapper = Mapper<UserModel>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
    }
    
    
    //MARK: - Register User
    class func registerUser(mobileNumber: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        let strURL = WS_REGISTER_USER
        
        //Final Dictionary
        let finalDict : [String: AnyObject] = ["Email"   : "" as AnyObject,
                                               "Password": "" as AnyObject,
                                               "Mobile"  : mobileNumber as AnyObject]
        
        print("Dictionary : \(finalDict)")
        
        WebSerivceManager.POSTRequest(url: strURL, showLoader: showLoader, Parameter: finalDict) { (isSuccess, response, error) in
            if response?.data == nil {
                completionHandler(isSuccess, nil, error)
            }else {
                //let array = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                //response?.formattedData = array as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
    }
}
