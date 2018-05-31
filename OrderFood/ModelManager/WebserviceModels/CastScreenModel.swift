//
//  CastScreenModel.swift
//  controlcast
//
//  Created by Mehul Solanki on 10/04/17.
//  Copyright © 2017 Openxcell Game. All rights reserved.
//

import UIKit
import ObjectMapper

class CastScreenModel: Mappable {
    
    var iCastID:            String?
    var iBroadcastUserID:   String?
    var vTitle:             String?
    var iBudget:            String?
    var eCastType:          String?
    var vImage:             String?
    var tLength:            String?
    var iDailyReplays:      String?
    var dStartedDate:       String?
    var dEndDate:           String?
    var eDraft:             String?
    var totalScreen:        String?
    var approvedScreen:     String?
    var isLive:             String?
    var isPendingMinApproved:             String?
    var iValidity:          String?
    var noofscreen:         String?
    var vName:              String?
    
    
    //Mapper Class Methods
    init() {
    }
    
    class var mapperObj : Mapper<CastScreenModel>  {
        let mapper : Mapper = Mapper<CastScreenModel>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        iCastID             <- map["iCastID"]
        iBroadcastUserID    <- map["iBroadcastUserID"]
        vTitle              <- map["vTitle"]
        iBudget             <- map["iBudget"]
        eCastType           <- map["eCastType"]
        vImage              <- map["vImage"]
        tLength             <- map["tLength"]
        dStartedDate        <- map["dStartedDate"]
        dEndDate            <- map["dEndDate"]
        eDraft              <- map["eDraft"]
        totalScreen         <- map["totalScreen"]
        approvedScreen      <- map["approvedScreen"]
        isLive              <- map["isLive"]
        isPendingMinApproved              <- map["isPendingMinApproved"]
        iValidity           <- map["iValidity"]
        noofscreen          <- map["noofscreen"]
        vName               <- map["vName"]
        iDailyReplays       <- map["iDailyReplays"]
    }
    
    
    //MARK: - Register Cast
    class func registerCast(showLoader: Bool, param: [String: AnyObject], completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
    
        print("Register Cast Dictionary : \(param)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.register_cast, showLoader: showLoader, Parameter: param) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                }else {
                }
                
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Register Cast
    class func editCast(showLoader: Bool, param: [String: AnyObject], completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        print("Register Cast Dictionary : \(param)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.edit_cast, showLoader: showLoader, Parameter: param) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                }else {
                }
                
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Send Signal to SERVER to Make Video
    class func makeVideoSignalToServer(showLoader: Bool, param: [String: AnyObject], completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        print("Make Video Dictionary : \(param)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.make_video_Cast, showLoader: showLoader, Parameter: param) { (isSuccess, response, error) in
            
            completionHandler(isSuccess, response, error)
        }
    }
    
    
    //MARK: - Cast - Get Approved Screen
    class func getCastApprovedList(showLoader: Bool, startCounter: String, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params: [String: AnyObject] = ["start": startCounter as AnyObject]
        
        print("Cast Approved List Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.approved_cast, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                    let castScreenModel = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                    response?.formattedData = castScreenModel as AnyObject?
                    
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Cast - Get Pending Screen
    class func getCastPendingList(showLoader: Bool, startCounter: String, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params: [String: AnyObject] = ["start": startCounter as AnyObject]
        
        print("Make Video Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.pending_cast, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                    let castScreenModel = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                    response?.formattedData = castScreenModel as AnyObject?
                    
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Delete Cast
    class func deleteCast(showLoader: Bool, param: [String: AnyObject], completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        print("Delete Cast Dictionary : \(param)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.delete_cast, showLoader: showLoader, Parameter: param) { (isSuccess, response, error) in
            
            completionHandler(isSuccess, response, error)
        }
    }
    
    
    //MARK: - Check Screen Availability
    class func checkScreensAvailability(showLoader: Bool, param: [String: AnyObject], completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        print("Check Screen Availability : \(param)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.screen_availability, showLoader: showLoader, Parameter: param) { (isSuccess, response, error) in
            
            completionHandler(isSuccess, response, error)
        }
    }
    
    
    
    
    //MARK: - Partner
    //MARK: - Get Requested Cast Screen
    class func getRequestedCastScreen(showLoader: Bool, startCounter: String, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params: [String: AnyObject] = ["start": startCounter as AnyObject]
        
        print("Requested Cast Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.requested_cast, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                    let castScreenModel = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                    response?.formattedData = castScreenModel as AnyObject?
                    
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    
    
    
}


//MARK: - Partner
//MARK: - Approved List
class ApprovedScreenModel: Mappable {
    
    internal var result: [CastScreenModel]?
    internal var showDate: String = ""
    
    
    init() {
        
    }
    
    class var mapperObj : Mapper<ApprovedScreenModel>  {
        let mapper : Mapper = Mapper<ApprovedScreenModel>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        do {
            let arrayResult: [[String : Any]] = try map.value("result")
            if arrayResult.count > 0 {
                result = CastScreenModel.mapperObj.mapArray(JSONArray: arrayResult)
            }
        }catch {
        }
        
        showDate <- map["showDate"]
    }
    
    
    //MARK: - Get Approved Cast Screen
    class func getApprovedCastScreen(strMonthYear: String, screenID: String, showLoader: Bool, startCounter: String, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params: [String: AnyObject] = ["date": strMonthYear as AnyObject,
                                           "iScreenID" : screenID as AnyObject]
        
        print("Approved Cast Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.approved_cast_partner, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                    let castScreenModel = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                    response?.formattedData = castScreenModel as AnyObject?
                    
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
}
