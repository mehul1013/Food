//
//  WebSerivceManager.swift
//  controlcast
//
//  Created by iPhone-4 on 16/02/17.
//  Copyright © 2017 Openxcell Game. All rights reserved.
//


import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON
import SystemConfiguration

enum Web_Service : String {
    case key = "key"
    case static_page = "admin/static_page"
    case login = "admin/login"
    case register_with_email = "admin/registration"
    case notificationSettingsChange = "user/changed_notification_status"
    case forgot_password = "admin/forgotPass"
    case change_password = "user/change_password"
    case notification_list = "user/getNotificationList"
    
    case country_list       = "admin/country"
    case state_list         = "admin/city"
    case city_list          = "admin/area"
    case industry_list      = "admin/industries"
    case contact_control_cast = "user/contactControlcast"
    case logout_user        = "user/logout"
    case manage_badge_count = "user/updateBaseCount"
    case unread_notification = "user/getNotificationBase"
    
    
    
    //Trusted & Blocked
    case add_to_block_list = "partner/addToBlock"
    case add_to_trusted_list = "partner/addToTrusted"
    
    case remove_from_blocked_list = "partner/removeBlocked"
    case remove_from_trusted_list = "partner/removeTrusted"
    
    case blocked_users_list = "partner/blockedList"
    case trusted_users_list = "partner/trustedList"
    
    
    case get_screen_data = "admin/getscreendata"
    
    case get_screen_listing = "partner/getScreenList"
    case register_screen    = "partner/addScreen"
    
    case get_ScreenByID_Name = "caster/getScreenDetailByID"
    case get_CastDetailByID  = "caster/getCastDetailsByID"
    
    case edit_profile_url = "user/editUserProfile"
    case viewProfile_By_ID = "user/getUserProfileByID"
    
    case get_Cast_SelectScreenDetail = "user/getCastSelectScreenDetail"
    
    case delete_screen = "partner/deleteScreen"
    case edit_screen   = "partner/editScreen"
    
    case shareCodeMessage   = "user/shareCodeMessage"
    case checkUserVerification   = "user/checkUserVerified"
    
    case screen_login   = "partner/screenLoginDetails"
    case make_video     = "partner/createScreenVideoImageText"
    
    //Cast
    case register_cast       = "caster/addCast"
    case edit_cast           = "caster/editCast"
    case make_video_Cast     = "caster/createVideoImageText"
    case pending_cast        = "caster/pendingCastList"
    case approved_cast       = "caster/approvedCastList"
    case screen_status       = "caster/getCastScreenStatus"
    case submit_feedback     = "caster/sendPatnerPendingMessage"
    case delete_cast         = "caster/deleteCast"
    //case filter_bulk_cast    = "caster/getScreenForBulkCast"
    case filter_bulk_cast    = "caster/getScreenForBulkCastV2"
    case add_credit          = "caster/createCharge"
    case history_caster      = "caster/getCastHistory"
    case screen_availability = "caster/checkscreensavailability"
    
    
    case screen_autocomplete = "user/getScreenListByAutocomplete"
    case referral_code       = "user/promoCodeCredit"
    case wallet_balance      = "user/getUserWallet"
    case get_bank_details    = "user/getBankDetailById"
    case transaction_history = "user/getTransactionHistory"
    case credit_list         = "user/browseplans"
    
    
    case requested_cast      = "partner/getRequestData"
    case approved_cast_partner = "partner/getApproveList"
    case cast_request_detail = "partner/getAllCastDetail"
    case approve_screen      = "partner/approveScreenCast"
    case reject_screen       = "partner/rejectScreenCast"
    case history_partner     = "partner/getCastHistory"
    
    case venue_name          = "partner/venueName"
    case transfer_credit     = "partner/transferCreditToCasterAccount"
    case submit_bank_info    = "partner/editBankDetails"
    case report_cast         = "partner/reportCast"
    case delete_cast_Partner = "partner/deleteCast"

    case version_control     = "version/checkVersion"
}

//MARK: base url
//let WS_BASE_URL: String = "http://fnb-admin.azurewebsites.net/apiapp/"
let WS_BASE_URL: String = "https://ezfnb-staging-api.azurewebsites.net/"

//MARK: WS REquest Constant
//let WS_GET_CATEGORY     = WS_BASE_URL + "GetQrCategory?QrString="
//let WS_GET_ITEM         = WS_BASE_URL + "getappfooditem?categoryid="
//let WS_SEARCH_ITEM      = WS_BASE_URL + "SearchFoodItem?prefix="
//let WS_CREATE_GUEST_CART = WS_BASE_URL + "CreateGuestcart"
//let WS_GET_CART_DETAIL  = WS_BASE_URL + "GetCartDetails?Guid="
//let WS_DELETE_CART      = WS_BASE_URL + "DeleteGuestCartItem?Guid="

let WS_REGISTER_USER        = WS_BASE_URL + "register.json"
let WS_GET_VENUE_INFO       = WS_BASE_URL + "venues/scan/"
let WS_GET_RESTAURANT       = WS_BASE_URL + "kitchens/list/"
let WS_GET_CART_DETAIL      = WS_BASE_URL + "guestcarts/read/"
let WS_CREATE_GUEST_CART    = WS_BASE_URL + "guestcarts/create.json"
let WS_DELETE_CART          = WS_BASE_URL + "guestcarts/items/delete/"
let WS_GET_CATEGORY         = WS_BASE_URL + "categories/list/"
let WS_GET_ITEM             = WS_BASE_URL + "items/list/"
let WS_SEARCH_ITEM          = WS_BASE_URL + "items/searchList/"
let WS_CURRENT_ORDER        = WS_BASE_URL + "orders/list/"
let WS_ORDER_INFO           = WS_BASE_URL + "orders/read/"




//MARK: - Check Internet Connection
func isInternetAvailable() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}

class WebSerivceManager:NSObject {
    
    let alamofireManager : Alamofire.SessionManager
    //static var defaultXAPIKey = "9cd65873c55ddc53f4be27d76e35f868232a8f09" //OLD
    static var defaultXAPIKey = "2592ea9f9ecc25bfcc562724dd674bde9c0a1830" //Hitesh
    
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 6000
        configuration.timeoutIntervalForResource = 6000 // seconds
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        
    }
    
    //Post method
    class func POSTRequest(url: String, showLoader : Bool, Parameter:[String : AnyObject]?, success:((Bool,WebServiceReponse?, Error?) -> Void)?)
    {
        
        //Check Internet Connection
        if isInternetAvailable() == false {
            //Show Alert
            let viewCTR = AppUtils.APPDELEGATE().getCurrentViewController()
            
            DispatchQueue.main.async {
                AppUtils.showAlertWithTitle(title: "No Internet Connection", message: "There is an issue with the network connection. Please check your setting and try again.", viewController: viewCTR)
            }
            
            return
        }
        
        
        if(showLoader) {
            //Run on main thread
            DispatchQueue.main.async {
                AppUtils.showLoader()
            }
        }
        
        print(Parameter as Any)
        
        //Header
        HeaderClass.objHeaderClass.HeaderDictionary = ["Authorization" : "Bearer 6aeb3973-e5af-4585-840f-14dca848f05a",
                                                       "Content-Type" : "application/json"]
        //HeaderClass.objHeaderClass.HeaderDictionary = ["Content-Type" : "application/json"]
        print(HeaderClass.objHeaderClass.HeaderDictionary)
        
        //Set Request Time
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60 // seconds
        let alamofireManager = Alamofire.SessionManager(configuration: configuration)
        
        print("URL : \(url)")
        
        alamofireManager.request(url, method: .post, parameters: Parameter, encoding: JSONEncoding.default, headers: HeaderClass.objHeaderClass.HeaderDictionary).responseJSON { (response:DataResponse<Any>) in
            alamofireManager.session.invalidateAndCancel()
            
            //var dataString = String(data: response.data!, encoding: .utf8)
            //print(dataString)
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil {
                    print("Response : \(response.result.value!)")
                    
                    //If user is not Authorise
                    if let dict = response.result.value as? [String : AnyObject] {
                        if let status = dict["STATUS"] as? Int {
                            print("Status : \(status)")
                            if status == 401 {
                                //Logout
                                let message = "\(dict["MESSAGE"]!)"
                                
                                let viewCTR = AppUtils.APPDELEGATE().window?.rootViewController as? UINavigationController
                                
                                //Not Authorise User
                                let alert = UIAlertController(title: "" as String , message: message, preferredStyle: .alert)
                                
                                let actionCameraImage = UIAlertAction(title: "OK", style: .default) {
                                    UIAlertAction in
                                    
                                    //Logout
                                    _ = viewCTR?.popToRootViewController(animated: true)
                                }
                                // Add the actions
                                alert.addAction(actionCameraImage)
                                viewCTR?.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    
                    WebSerivceManager.HandleResponse(apicallMethod: url, apiResponse: response, successHandler: { (isSuccess, BaseModel, error) in
                        if let successBlock = success {
                            successBlock(isSuccess, BaseModel, error)
                        }
                    })
                }
                break
            
            case .failure(_):
                if let errorCode : Int = (response.result.error as? NSError)?.code{
                    
                    print("ErrorCode \(errorCode) \n \(response)")
                    
                    if (response.result.error as? NSError)?.code == -1005 {
                        
                        Alamofire.request(url, method: .post, parameters: Parameter, encoding: JSONEncoding.default, headers: HeaderClass.objHeaderClass.HeaderDictionary).responseJSON { (response:DataResponse<Any>) in
                            
                            switch(response.result) {
                            case .success(_):
                                if response.result.value != nil{
                                    print(response.result.value!)
                                    WebSerivceManager.HandleResponse(apicallMethod: url, apiResponse: response, successHandler: { (isSuccess, BaseModel, error) in
                                        if let successBlock = success {
                                            successBlock(isSuccess, BaseModel, error)
                                        }
                                    })
                                }
                                break
                                
                            case .failure(_):
                                print(response.result.error!)
                                //Run on main thread
                                DispatchQueue.main.async {
                                    AppUtils.hideLoader()
                                }
                                break
                            }
                        }
                    }else {
                        //Run on main thread
                        DispatchQueue.main.async {
                            AppUtils.hideLoader()
                        }
                        
                        if let successBlock = success {
                            successBlock(false, nil, response.result.error)
                        }
                    }
                }else{
                    if let successBlock = success {
                        successBlock(false, nil, response.result.error)
                    }
                }
                break
            }
        }
    }
    
    //GET method
    class func GETRequest(url: String, showLoader : Bool, success:((Bool,WebServiceReponse?, Error?) -> Void)?)
    {
        
        //Check Internet Connection
        if isInternetAvailable() == false {
            //Show Alert
            let viewCTR = AppUtils.APPDELEGATE().getCurrentViewController()
            
            DispatchQueue.main.async {
                AppUtils.showAlertWithTitle(title: "No Internet Connection", message: "There is an issue with the network connection. Please check your setting and try again.", viewController: viewCTR)
            }
            
            return
        }
        
        
        if(showLoader) {
            AppUtils.showLoader()
        }
        
        //Header
        //HeaderClass.objHeaderClass.HeaderDictionary = ["Authorization" : "Bearer 6aeb3973-e5af-4585-840f-14dca848f05a"]
        
        HeaderClass.objHeaderClass.HeaderDictionary = ["Authorization" : "Bearer \(AppUtils.APPDELEGATE().token)",
                                                       "Content-Type" : "application/json"]
        
        /*HeaderClass.objHeaderClass.HeaderDictionary = ["Authorization" : "Bearer 80b203a0-4d81-4a7a-b3f0-ccb3b4ed7ec4",
                                                       "Content-Type" : "application/json"]*/
        print(HeaderClass.objHeaderClass.HeaderDictionary)
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.objHeaderClass.HeaderDictionary).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                    WebSerivceManager.HandleResponse(apicallMethod: url, apiResponse: response, successHandler: { (isSuccess, BaseModel, error) in
                        if let successBlock = success {
                            successBlock(isSuccess, BaseModel, error)
                        }
                    })
                }
                break
                
            case .failure(_):
                AppUtils.hideLoader()
                if let successBlock = success {
                    successBlock(false, nil, response.result.error)
                }
                print(response.result.error!)
                break
                
            }
        }
    }
    
    //POST Multipart
    class func POSTMultipartRequest(url : String, parameterDitionary: [String : String]? , parameterwithImage : [String : String]?, success:((Bool,WebServiceReponse?, Error?) -> Void)?) {
        
        AppUtils.showLoader()
        print(HeaderClass.objHeaderClass.HeaderDictionary!)
        print("Parameter\(parameterDitionary!)")
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameterDitionary! {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            //image append
            for (key, value) in parameterwithImage! {
                multipartFormData.append(NSURL(string:(value)) as URL!, withName: key)
            }
            
        }, to: url, headers: HeaderClass.objHeaderClass.HeaderDictionary)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    print(response.request!)  // original URL request
                    print(response.response!) // URL response
                    print(response.data!)     // server data
                    print(response.result)   // result of response serialization
                    
                    WebSerivceManager.HandleResponse(apicallMethod: url, apiResponse: response, successHandler: { (isSuccess, BaseModel, error) in
                        if let successBlock = success {
                            successBlock(isSuccess, BaseModel, error)
                        }
                    })
                }
                
            case .failure(let error):
                AppUtils.hideLoader()
                print(result)
                if let successBlock = success {
                    successBlock(false, nil, error)
                }
                break
            }
        }
    }
    
    //Success Response Handle
    class func HandleResponse (apicallMethod: String, apiResponse : DataResponse<Any>, successHandler: ((Bool,WebServiceReponse?, Error?)->Void)) {
        
        AppUtils.hideLoader()
        if let JSON = apiResponse.result.value {
            //print("JSON: \(JSON)")
            
            let mapper = Mapper<WebServiceReponse>()
            let dataObject : WebServiceReponse = mapper.map(JSON: JSON as! [String : Any])!
            
            //successHandler(true, dataObject, nil)
            //If block added by MeHuLa on 18 May 2017
            /*if dataObject.success == true {
                successHandler(true, dataObject, nil)
            }else {
                successHandler(false, dataObject, nil)
            }*/
            
            if dataObject.success == 0 {
                successHandler(false, dataObject, nil)
            }else {
                successHandler(true, dataObject, nil)
            }
            
        }else {
            successHandler(false, nil, apiResponse.result.error)
        }
    }
    
    
    
    
    
    //MARK: - Google Autocomplete Adderss
    func getGooglePlace(showLoader: Bool, isForCityOnly: Bool, strSearchText:String, success:@escaping (Array<Any>) -> Void, failed:@escaping (String) -> Void) {
        
        //        https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY
        
        
        let urlwithPercentEscapes = strSearchText.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        //              https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=YOUR_API_KEY&language=fr&input=pizza+near%20par
        
        //Run on main thread
        DispatchQueue.main.async {
            AppUtils.showLoader()
        }
        
        var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(urlwithPercentEscapes!)&key=\(Constants.kGoogle_Places_API)"
        
        //If creteria depends on CITY
        if isForCityOnly == true {
            url = url + "&types=(cities)"
        }
        
        print("----------------------\n\n\n\nURL: \(url)")
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            //Run on main thread
            DispatchQueue.main.async {
                AppUtils.hideLoader()
            }
            
            switch(response.result) {
                
            case .success(_):
                print("Response: \(response.result.value as Any!)")
                
                var dict = JSON(response.result.value ?? "").dictionaryValue
                
                if(dict["status"] == "OK") {
                    success((dict["predictions"]?.array)!)
                }else {
                    failed("The network connection was lost please try again.")
                }
                
                break
                
            case .failure(_):
                print("Response: \(response.result.error as Any!)")
                failed("The network connection was lost please try again.")
                break
                
            }
        }
    }
    
    
    //MARK: - Get LAt Long from Address
    func getLotLongFromAddress(showLoader: Bool, strPlace:String, success:@escaping (Array<Any>) -> Void, failed:@escaping (String) -> Void) {
        
        let urlwithPercentEscapes = strPlace.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        //Run on main thread
        DispatchQueue.main.async {
            AppUtils.showLoader()
        }
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json?address=\(urlwithPercentEscapes!)&key=\(Constants.kGoogle_Places_API)"
        
        print("----------------------\n\n\n\nURL: \(url)")
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            //Run on main thread
            DispatchQueue.main.async {
                AppUtils.hideLoader()
            }
            
            switch(response.result) {
                
            case .success(_):
                print("Response: \(response.result.value as Any!)")
                
                var dict = JSON(response.result.value ?? "").dictionaryValue
                if(dict["status"] == "OK") {
                    success((dict["results"]?.array)!)
                }else {
                    success([[]])
                }
                break
                
            case .failure(_):
                print("Response: \(response.result.error as Any!)")
                failed("The network connection was lost please try again.")
                break
                
            }
        }
    }
    
    
    //MARK: - Get Address from Lat Long
    func getAddressFromLotLong(showLoader: Bool, strLatitude: String, strLongitude: String, success:@escaping (Array<Any>) -> Void, failed:@escaping (String) -> Void) {
        
        let strLocation = "\(strLatitude),\(strLongitude)"
        
        //Run on main thread
        DispatchQueue.main.async {
            AppUtils.showLoader()
        }
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(strLocation)&sensor=true&key=\(Constants.kGoogle_Places_API)"
        
        print("----------------------\n\n\n\nURL: \(url)")
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            //Run on main thread
            DispatchQueue.main.async {
                AppUtils.hideLoader()
            }
            
            switch(response.result) {
                
            case .success(_):
                print("Response: \(response.result.value as Any!)")
                
                var dict = JSON(response.result.value ?? "").dictionaryValue
                if(dict["status"] == "OK") {
                    success((dict["results"]?.array)!)
                }else {
                    success([[]])
                }
                break
                
            case .failure(_):
                print("Response: \(response.result.error as Any!)")
                failed("The network connection was lost please try again.")
                break
                
            }
        }
    }
}

extension String {
    func EncodingText() -> NSData {
        return self.data(using: String.Encoding.utf8, allowLossyConversion: false)! as NSData
    }
}
