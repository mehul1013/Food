//
//  CastDetailModel.swift
//  controlcast
//
//  Created by Mehul Solanki on 12/04/17.
//  Copyright © 2017 Openxcell Game. All rights reserved.
//

import UIKit
import ObjectMapper


class CastDetailModel: Mappable {

    var iCastID:                String?
    var iBroadcastUserID:       String?
    var vTitle:                 String?
    var vImage:                 String?
    var vVideo:                 String?
    var tTotalAirplay:          String?
    var iTotalReplays:          String?
    var iDailyReplays:          String?
    var iDailyReplayPerScreen:  String?
    var dStartedDate:           String?
    var iValidity:              String?
    var tLength:                String?
    var iMinScreenApprovals:    String?
    var iBudget:                String?
    var vName:                  String?
    var tText:                  String?
    var eCastType:              String?
    var tActualAirtime:         String?
    var tActualDailyAirtime:    String?
    var iActualReplays:         String?
    var dActualCost:            String?
    var iActualDailyReplay:     String?
    var iActualDailyReplayPerScreen: String?
    var dActualReplay:          String?
    var tActualAirTime:         String?
    
    //var screens: [ScreenStatusModel]?
    //var screens = [ScreenDetailModel]()

    //Mapper Class Methods
    init() {
    }
    
    class var mapperObj : Mapper<CastDetailModel>  {
        let mapper : Mapper = Mapper<CastDetailModel>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        iCastID                 <- map["iCastID"]
        iBroadcastUserID        <- map["iBroadcastUserID"]
        vTitle                  <- map["vTitle"]
        vImage                  <- map["vImage"]
        vVideo                  <- map["vVideo"]
        tTotalAirplay           <- map["tTotalAirplay"]
        iTotalReplays           <- map["iTotalReplays"]
        iDailyReplays           <- map["iDailyReplays"]
        iDailyReplayPerScreen   <- map["iDailyReplayPerScreen"]
        dStartedDate            <- map["dStartedDate"]
        iValidity               <- map["iValidity"]
        tLength                 <- map["tLength"]
        iMinScreenApprovals     <- map["iMinScreenApprovals"]
        iBudget                 <- map["iBudget"]
        vName                   <- map["vName"]
        tText                   <- map["tText"]
        eCastType               <- map["eCastType"]
        tActualAirtime          <- map["tActualAirtime"]
        tActualDailyAirtime     <- map["tActualDailyAirtime"]
        iActualReplays          <- map["iActualReplays"]
        dActualCost             <- map["dActualCost"]
        iActualDailyReplayPerScreen             <- map["iActualDailyReplayPerScreen"]
        iActualDailyReplay      <- map["iActualDailyReplay"]
        tActualAirTime          <- map["tActualAirTime"]
        dActualReplay           <- map["dActualReplay"]
        
        
        do {
            let photoArray:[[String : Any]] = try map.value("screens")
            if photoArray.count > 0 {
                //screens = ScreenStatusModel.mapperObj.mapArray(JSONArray: photoArray)
                //screens = ScreenDetailModel.mapperObj.mapArray(JSONArray: photoArray)!
            }
        }catch {
            
        }
    }
    
    
    //MARK: - Web Service
    //MARK: - Get Cast Detail By ID
    class func getCastDetail(ByID id: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["iCastID" : id as AnyObject]
        print("Get Cast Detail Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.get_CastDetailByID, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if error != nil {
                completionHandler(isSuccess, response, error)
            }else {
                if isSuccess == true {
                    if response?.success == true {
                        let parnerScreenModel = self.mapperObj.map(JSON: response!.data as! [String : Any])!
                        response?.formattedData = parnerScreenModel as AnyObject?
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
    //MARK: - Cast Request Details
    class func getCastRequestDetail(ByID id: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["iCastID" : id as AnyObject]
        print("Get Cast Detail Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.cast_request_detail, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                    let parnerScreenModel = self.mapperObj.map(JSON: response!.data as! [String : Any])!
                    response?.formattedData = parnerScreenModel as AnyObject?
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, nil, error)
            }
        }
    }
    
    //MARK: - Approve Screen
    class func approveScreen(ByIDs ids: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["iCastScreenID" : ids as AnyObject]
        print("Approve Screen Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.approve_screen, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    //MARK: - Reject Screen
    class func rejectScreen(ByIDs ids: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["iCastScreenID" : ids as AnyObject]
        print("Reject Screen Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.reject_screen, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
}



//Screen Model
class ScreenStatusModel: Mappable {
    internal var iCastScreenID: String = ""
    internal var iScreenID:     String = ""
    internal var vImage:        String = ""
    internal var vScreenID:     String = ""
    internal var vVenueName:    String = ""
    internal var vVenuePlace:   String = ""
    internal var vAddress:      String = ""
    internal var eApproval:     String = ""
    
    //Added later on April 17, 2017
    internal var dLat:                  String = ""
    internal var dLong:                 String = ""
    internal var eDayOfOpration:        String = ""
    internal var eDefaultType:          String = ""
    internal var eIsPhoto:              String = ""
    internal var eIsSupportingDocument: String = ""
    internal var eOriension:            String = ""
    internal var eSound:                String = ""
    internal var eTier:                 String = ""
    internal var eTrusted:              String = ""
    internal var iDamensionID:          String = ""
    internal var iIndustriesID:         String = ""
    internal var iLocationtypeID:       String = ""
    internal var iScreentypeID:         String = ""
    internal var iTotalCast:            String = ""
    internal var iUserId:               String = ""
    internal var tDescription:          String = ""
    internal var tDisplayEndtime:       String = ""
    internal var tDisplayStarttime:     String = ""
    internal var tText:                 String = ""
    internal var vDamension:            String = ""
    internal var vDefaultVideo:         String = ""
    internal var vIndustries:           String = ""
    internal var vLocationtype:         String = ""
    internal var vName:                 String = ""
    internal var vQRcode:               String = ""
    internal var vScreentype:           String = ""
    
    //var document:   [ScreenDocumentModel]?
    //var photo:      [ScreenPhotoModel]?
    
    
    
    //Other Perameter for Partner
    internal var iCastID:     String = ""
    
    init() {
        
    }
    
    class var mapperObj : Mapper<ScreenStatusModel>  {
        let mapper : Mapper = Mapper<ScreenStatusModel>()
        return mapper
    }
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        iCastScreenID   <- map["iCastScreenID"]
        iScreenID       <- map["iScreenID"]
        vImage          <- map["vImage"]
        vScreenID       <- map["vScreenID"]
        vVenueName      <- map["vVenueName"]
        vVenuePlace     <- map["vVenuePlace"]
        vAddress        <- map["vAddress"]
        eApproval       <- map["eApproval"]
        
        dLat                  <- map["dLat"]
        dLong                 <- map["dLong"]
        eDayOfOpration        <- map["eDayOfOpration"]
        eDefaultType          <- map["eDefaultType"]
        eIsPhoto              <- map["eIsPhoto"]
        eIsSupportingDocument <- map["eIsSupportingDocument"]
        eOriension            <- map["eOriension"]
        eSound                <- map["eSound"]
        eTier                 <- map["eTier"]
        eTrusted              <- map["eTrusted"]
        iDamensionID          <- map["iDamensionID"]
        iIndustriesID         <- map["iIndustriesID"]
        iLocationtypeID       <- map["iLocationtypeID"]
        iScreentypeID         <- map["iScreentypeID"]
        iTotalCast            <- map["iTotalCast"]
        iUserId               <- map["iUserId"]
        tDescription          <- map["tDescription"]
        tDisplayEndtime       <- map["tDisplayEndtime"]
        tDisplayStarttime     <- map["tDisplayStarttime"]
        tText                 <- map["tText"]
        vDamension            <- map["vDamension"]
        vDefaultVideo         <- map["vDefaultVideo"]
        vIndustries           <- map["vIndustries"]
        vLocationtype         <- map["vLocationtype"]
        vName                 <- map["vName"]
        vQRcode               <- map["vQRcode"]
        vScreentype           <- map["vScreentype"]
        
        do {
            let photoArray:[[String : Any]] = try map.value("photo")
            if photoArray.count > 0 {
                //photo = ScreenPhotoModel.mapperObj.mapArray(JSONArray: photoArray)
            }
        }catch {
            
        }
        
        do {
            let documentArray:[[String : Any]] = try map.value("document")
            if documentArray.count > 0 {
                //document = ScreenDocumentModel.mapperObj.mapArray(JSONArray: documentArray)
            }
        }catch {
            
        }
    }
    
    
    
    //MARK: - Cast - Get Screen Status
    class func getScreenStatus(showLoader: Bool, castID: String, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params: [String: AnyObject] = ["iCastID": castID as AnyObject]
        
        print("Screen Status Dictionary : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.screen_status, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                    let castScreenModel = self.mapperObj.mapArray(JSONArray: response?.data as! [[String : Any]])
                    response?.formattedData = castScreenModel as AnyObject?
                    
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, nil, error)
            }
        }
    }
    
    
    //MARK: - Submit Feedback
    class func submitFeedback(showLoader: Bool, param: [String: AnyObject], completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        print("Submit Feedback Dictionary : \(param)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.submit_feedback, showLoader: showLoader, Parameter: param) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, nil, error)
            }
        }
    }
}
