    //
//  UserProfileModel.swift
//  controlcast
//
//  Created by iPhone-4 on 15/02/17.
//  Copyright © 2017 Openxcell Game. All rights reserved.
//

import UIKit
import ObjectMapper

class UserProfileModel: NSObject, NSCoding, Mappable {

    internal var userId : String?
    internal var name : String?
    internal var email : String?
    internal var userType:String?
    internal var broadCastType : String?
    internal var userDescription : String?
    internal var gender : String?
    internal var dateOfBirth : String?
    internal var company : String?
    internal var industry : String?
    internal var country : String?
    internal var city : String?
    internal var area : String?
    internal var profileImage : String?
    internal var address : String?
    internal var latitude : Double?
    internal var longitude : Double?
    internal var referralCode: String?
    internal var notificationStatus:Bool = true
    internal var accessToken:String?
    internal var emailVerified: Bool = false
    internal var casterType : String?
    
    internal var dateCreated:String?
    internal var isBankDetails:String?
    internal var areaId:String?
    internal var cityId:String?
    internal var countryId:String?
    internal var industryId:String?
    internal var totalBalance:String?
    internal var isProfileFullfill: String?
    
    static var SharedInstance = UserProfileModel()
    
    
    override init() {
    }
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        self.userId = decoder.decodeObject(forKey: "userId") as? String ?? ""
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
        self.userType = decoder.decodeObject(forKey: "userType") as? String ?? ""
        self.broadCastType = decoder.decodeObject(forKey: "broadCastType") as? String ?? ""
        self.userDescription = decoder.decodeObject(forKey: "description") as? String ?? ""
        self.gender = decoder.decodeObject(forKey: "gender") as? String ?? ""
        self.dateOfBirth = decoder.decodeObject(forKey: "dateOfBirth") as? String ?? ""
        self.company = decoder.decodeObject(forKey: "company") as? String ?? ""
        self.industry = decoder.decodeObject(forKey: "industry") as? String ?? ""
        self.country = decoder.decodeObject(forKey: "country") as? String ?? ""
        self.city = decoder.decodeObject(forKey: "city") as? String ?? ""
        self.area = decoder.decodeObject(forKey: "area") as? String ?? ""
        self.profileImage = decoder.decodeObject(forKey: "profileImage") as? String ?? ""
        self.address = decoder.decodeObject(forKey: "address") as? String ?? ""
//        self.latitude = decoder.decodeDouble(forKey: "latitude")
//        self.longitude = decoder.decodeDouble(forKey: "longitude")
        self.referralCode = decoder.decodeObject(forKey: "referralCode") as? String ?? ""
        self.accessToken = decoder.decodeObject(forKey: "accessToken") as? String ?? ""
        self.notificationStatus = decoder.decodeBool(forKey:"notificationStatus")
        self.casterType = decoder.decodeObject(forKey: "casterType") as? String ?? ""
        
        self.emailVerified = decoder.decodeBool(forKey:"eEmailVerified")

        self.dateCreated = decoder.decodeObject(forKey: "dateCreated") as? String ?? ""
        self.isBankDetails = decoder.decodeObject(forKey: "isBankDetails") as? String ?? ""
        self.areaId = decoder.decodeObject(forKey: "areaId") as? String ?? ""
        self.cityId = decoder.decodeObject(forKey: "cityId") as? String ?? ""
        self.countryId = decoder.decodeObject(forKey: "countryId") as? String ?? ""
        self.industryId = decoder.decodeObject(forKey: "industryId") as? String ?? ""
        self.totalBalance = decoder.decodeObject(forKey: "totalBalance") as? String ?? ""
        
        self.isProfileFullfill = decoder.decodeObject(forKey: "isProfileFullfill") as? String ?? ""
    }
    
    func encode(with coder: NSCoder)
    {
        coder.encode(userId, forKey: "userId")
        coder.encode(name, forKey: "name")
        coder.encode(email, forKey: "email")
        coder.encode(userType, forKey: "userType")
        coder.encode(broadCastType, forKey: "broadCastType")
        coder.encode(userDescription, forKey: "description")
        coder.encode(gender, forKey: "gender")
        coder.encode(dateOfBirth, forKey: "dateOfBirth")
        coder.encode(company, forKey: "company")
        coder.encode(industry, forKey: "industry")
        coder.encode(country, forKey: "country")
        coder.encode(city, forKey: "city")
        coder.encode(city, forKey: "area")
        coder.encode(profileImage, forKey: "profileImage")
        coder.encode(address, forKey: "address")
        coder.encode(latitude, forKey: "latitude")
        coder.encode(longitude, forKey: "longitude")
        coder.encode(referralCode, forKey: "referralCode")
        coder.encode(accessToken, forKey: "accessToken")
        coder.encode(notificationStatus, forKey: "notificationStatus")
        coder.encode(casterType, forKey: "casterType")
        
        coder.encode(emailVerified, forKey: "eEmailVerified")

        coder.encode(dateCreated, forKey: "dateCreated")
        coder.encode(isBankDetails, forKey: "isBankDetails")
        coder.encode(cityId, forKey: "areaId")
        coder.encode(cityId, forKey: "cityId")
        coder.encode(countryId, forKey: "countryId")
        coder.encode(industryId, forKey: "industryId")
        coder.encode(totalBalance, forKey: "totalBalance")
        coder.encode(totalBalance, forKey: "isProfileFullfill")
    }
    
    class var mapperObj : Mapper<UserProfileModel>  {
        let mapper : Mapper = Mapper<UserProfileModel>()
        return mapper
    }
    
    func mapping(map: Map) {
        userId <- map["iUserId"]
        name <- map["vName"]
        email <- map["vEmail"]
        userType <- map["eUserType"]

        broadCastType <- map["eBroadcastType"]
        userDescription <- map["tDescription"]
        gender <- map["eGender"]
        dateOfBirth <- map["dDOB"]
        
        company <- map["vCompany"]
        industry <- map["vIndustry"]
        country <- map["vCountry"]
        city <- map["vCity"]
        area <- map["vAreaName"]
        profileImage <- map["vProfileImage"]
        
        address <- map["vAddress"]
        latitude <- map["dLat"]
        longitude <- map["dLong"]
        referralCode <- map["vReferralCode"]
        
        casterType <- map["eBroadcastType"]

        dateCreated <- map["dtCreated"]
        isBankDetails <- map["eBankDetails"]
        areaId <- map["iAreaID"]
        cityId <- map["iCityID"]
        countryId <- map["iCountry"]
        industryId <- map["iIndustriesID"]
        totalBalance <- map["totalBalance"]
        
        emailVerified <- map["eEmailVerified"]
        
        isProfileFullfill <- map["isProfileFullfill"]
        
        
        do{
            if try map.value("eNotificationstatus") == "0" {
                notificationStatus = false;
            }else {
                notificationStatus = true;
            }
        }catch {
        }
        
        accessToken <- map["accesstoken"]
    }
    
    func saveObjectToLocalCache() {
        //save to nsuserdefaults
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: UserProfileModel.SharedInstance)
        Constants.UserDefault.set(encodedData, forKey: Constants.UserDefaultConstant.userProfileInfo)
        Constants.UserDefault.synchronize()
    }
    
    class func loadDataFromLocalCache() {
        let encodedData:Data? = Constants.UserDefault.object(forKey: Constants.UserDefaultConstant.userProfileInfo) as? Data
        if let data = encodedData {
            UserProfileModel.SharedInstance = (NSKeyedUnarchiver.unarchiveObject(with: data) as? UserProfileModel)!
        }
    }
    
    class func callKeyApi(isshowLoader : Bool, completionHandler:@escaping ((Bool) -> Void)) {
        HeaderClass.objHeaderClass.HeaderDictionary = ["X-API-KEY": WebSerivceManager.defaultXAPIKey]
        
        WebSerivceManager.POSTRequest(url: Web_Service.key, showLoader: isshowLoader, Parameter: nil) { (isSuccess, response, error) in
            
            if isSuccess == true {                
                //save key locally
                Constants.UserDefault.set(response?.key , forKey: Constants.UserDefaultConstant.userKey)
                Constants.UserDefault.synchronize()
                
                //check for
                HeaderClass.objHeaderClass.HeaderDictionary?.removeAll()
                HeaderClass.objHeaderClass.HeaderDictionary = ["X-API-KEY": response!.key!]
                
                //Return Block
                completionHandler(true)
            }
        }
    }
    
    
    // MARK: - Call API
    class func loginUser(name: String, email: String, password: String, deviceToken: String, platFormString: String, facebookID: String, twitterID: String, userType: String, strImageName: String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["vName"        : name              as AnyObject,
                                         "vEmail"       : email             as AnyObject,
                                         "vPassword"    : password          as AnyObject,
                                         "ePlatform"    : platFormString    as AnyObject,
                                         "vDeviceToken" : deviceToken       as AnyObject,
                                         "iFacebookID"  : facebookID        as AnyObject,
                                         "iTwitterID"   : twitterID         as AnyObject,
                                         "eUserType"    : userType          as AnyObject,
                                         "vProfileImage": strImageName      as AnyObject]
        
        print("URL : \(Web_Service.login)")
        print("Params : \(params)")
        
        WebSerivceManager.POSTRequest(url: Web_Service.login, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
                        
            if isSuccess == true {
                if response?.success == true {
                    print("Response : \(response!.data as! [String : Any])")
                    
                    UserProfileModel.SharedInstance = UserProfileModel.mapperObj.map(JSON: response!.data as! [String : Any])!
                    response?.formattedData = UserProfileModel.SharedInstance
                    
                    completionHandler(isSuccess, response, error)
                }else {
                    
                    completionHandler(false, response, error)
                }
            }
            else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    // MARK: - Call API
    class func editProfile(name: String, description: String, gender: String, dateOfBirth: String, company: String, industry: String, country: String, city: String, area: String, casterType: String, imageProfile: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["vName"        : name          as AnyObject,
                                         //"eGender"      : gender        as AnyObject,
                                         //"dDOB"         : dateOfBirth   as AnyObject,
                                         "vCompany"     : company       as AnyObject,
                                         "vIndustry"    : industry      as AnyObject,
                                         "vCountry"     : country       as AnyObject,
                                         "vCity"        : city          as AnyObject,
                                         "iAreaID"      : area          as AnyObject,
                                         "eBroadcastType"      : casterType    as AnyObject,
                                         "tDescription" : description   as AnyObject,
                                         "vProfileImage": imageProfile  as AnyObject]
        
        print(params)
        WebSerivceManager.POSTRequest(url: Web_Service.edit_profile_url, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    
    // MARK: - Call API
    class func registerUser(name:String, email:String, password:String, country: String, deviceToken:String, platFormString:String, referralCode:String, userType:String, profileImage:String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["vName"            : name           as AnyObject,
                                         "vEmail"           : email          as AnyObject,
                                         "vPassword"        : password       as AnyObject,
                                         "vCountry"         : country       as AnyObject,
                                         "ePlatform"        : platFormString as AnyObject,
                                         "vDeviceToken"     : deviceToken    as AnyObject,
                                         "vUsedReferralCode": referralCode   as AnyObject,
                                         "eUserType"        : userType       as AnyObject,
                                         "vProfileImage"    : profileImage   as AnyObject]
        
        print(params)
        WebSerivceManager.POSTRequest(url: Web_Service.register_with_email, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                    print("Image URL : \(response!.data as! [String : Any])")
                    
                    UserProfileModel.SharedInstance = UserProfileModel.mapperObj.map(JSON: response!.data as! [String : Any])!
                    response?.formattedData = UserProfileModel.SharedInstance
                }else {
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }

    
    class func changeNotificationSettings(notificationStatus:String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["eNotificationstatus":notificationStatus as AnyObject]
        
        WebSerivceManager.POSTRequest(url: Web_Service.notificationSettingsChange, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    class func forgotPassword(email:String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        var strUserType = ""
        if true {
            strUserType = "caster"
        }else {
            strUserType = "partner"
        }
        
        let params:[String:AnyObject] = ["vEmail"    :  email       as AnyObject,
                                         "eUserType" :  strUserType as AnyObject]
        
        WebSerivceManager.POSTRequest(url: Web_Service.forgot_password, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    class func changePassword(oldPassword:String, newPassword:String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["vOldPassword":oldPassword as AnyObject, "vNewPassword":newPassword as AnyObject]

        
        WebSerivceManager.POSTRequest(url: Web_Service.change_password, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    class func contactControlCast(subject:String, description:String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {

        let params:[String:AnyObject] = ["vSubject":subject as AnyObject, "tDescription":description as AnyObject]
        WebSerivceManager.POSTRequest(url: Web_Service.contact_control_cast, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Logout
    class func logoutUser(showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        WebSerivceManager.POSTRequest(url: Web_Service.logout_user, showLoader: showLoader, Parameter: nil) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - View Profile by ID
    class func viewProfile(ByID strID: String, showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        let params:[String:AnyObject] = ["iUserID" : strID   as AnyObject]
        
        print(params)
        WebSerivceManager.POSTRequest(url: Web_Service.viewProfile_By_ID, showLoader: showLoader, Parameter: params) { (isSuccess, response, error) in
            
            if isSuccess == true {
                if response?.success == true {
                    
                    let user = self.mapperObj.map(JSON: response!.data as! [String : Any])!
                    response?.formattedData = user as AnyObject?
                    
                    //UserProfileModel.SharedInstance = UserProfileModel.mapperObj.map(JSON: response!.data as! [String : Any])!
                    //response?.formattedData = UserProfileModel.SharedInstance
                }else {
                    
                }
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Manage Badge Count
    class func manageBadgeCount(showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        WebSerivceManager.POSTRequest(url: Web_Service.manage_badge_count, showLoader: showLoader, Parameter: nil) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Report Cast
    class func reportCast(showLoader: Bool, param: [String: AnyObject], completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        WebSerivceManager.POSTRequest(url: Web_Service.report_cast, showLoader: showLoader, Parameter: param) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    //MARK: - Delete Cast from Partner
    class func deleteCastForPartner(showLoader: Bool, param: [String: AnyObject], completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        WebSerivceManager.POSTRequest(url: Web_Service.delete_cast_Partner, showLoader: showLoader, Parameter: param) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
    
    //MARK: - Check for unread notification
    class func checkUnreadNotification(showLoader:Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        WebSerivceManager.GETRequest(url: Web_Service.unread_notification, showLoader: showLoader) { (isSuccess, response, error) in
            
            if isSuccess == true {
                completionHandler(isSuccess, response, error)
            }else {
                completionHandler(isSuccess, response, error)
            }
        }
    }
    
}
