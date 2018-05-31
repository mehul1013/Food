//
//  VersionControl.swift
//  controlcast
//
//  Created by Mehul Solanki on 14/12/17.
//  Copyright © 2017 Openxcell Game. All rights reserved.
//

import UIKit
import ObjectMapper

class VersionControl: Mappable {

    internal var vVersion:      String = ""
    internal var Message:       String = ""
    internal var vVersionType:  String = ""
    
    init() {
    }
    
    class var mapperObj : Mapper<VersionControl>  {
        let mapper : Mapper = Mapper<VersionControl>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        vVersion        <- map["vVersion"]
        Message         <- map["Message"]
        vVersionType    <- map["vVersionType"]
    }
    
    
    //MARK: - Get Version Control Information
    class func getVersionControlInfo(showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print(version)
            
            let params:[String:AnyObject] = ["ePlatform"    : "iOS" as AnyObject,
                                             "eAppType"     : "user" as AnyObject,
                                             "vVersion"     : version as AnyObject]
            
            WebSerivceManager.POSTRequest(url: Web_Service.version_control, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
                
                if isSuccess == true {
                    if response?.success == true {
                        print("Response : \(response?.data)")
                        let dict = self.mapperObj.map(JSON: (response?.data)! as! [String : Any])
                        response?.formattedData = dict as AnyObject?
                    }else {
                    }
                    completionHandler(isSuccess, response, error)
                }else {
                    completionHandler(isSuccess, nil, error)
                }
            }
        }
    }
}
