//
//  Constants.swift
//  controlcast
//
//  Created by Openxcell Game on 24/11/16.
//  Copyright © 2016 Openxcell Game. All rights reserved.
//

import UIKit



class Constants: NSObject {
    
    //RazorPay - MeHuLa Account
    //https://dashboard.razorpay.com/#/app/keys
    //https://razorpay.com/docs/ios/
    //https://cocoapods.org/pods/razorpay-pod
    static let KEY_ID_RAZORPAY_SANDBOX = "rzp_test_N5gzG5i6KfIps5"
    static let KEY_SECRET_RAZORPAY_SANDBOX = "Rf6ETPvwtvz3JV0Kn6waJMdb"
    
    //Authorised.Net - Testing from GitHub Sample
    static let kClientName_AUTHORISE_SANDBOX = "5KP3u95bQpv"
    static let kClientKey_AUTHORISE_SANDBOX  = "5FcB6WrfHGS76gHW3v7btBCE3HuuBuke9Pj96Ztfn5R32G5ep42vne7MCWZtAucY"
    
    
    //Static Pages
    static let TERMS_CONDITIONS     = "https://www.controlcastapp.com/terms-conditions/"
    static let PRIVACY_POLICY       = "https://www.controlcastapp.com/privacy-policy/"
    static let ABOUT_US             = "https://www.controlcastapp.com/about-us/"
    static let FAQ                  = "https://www.controlcastapp.com/faq/"
    
    
    //AWS S3 Directory
    static let Bucket_Path_ProfileImage     = "control-cast/userprofile"
    static let Bucket_Path_Parner_Photos    = "control-cast/screen/screenphoto"
    static let Bucket_Path_Parner_Docs      = "control-cast/screen/screendocument"
    static let Bucket_Path_Parner_DefaultImage      = "control-cast/screen/screendefaultimage"
    static let Bucket_Path_Parner_DefaultVideo      = "control-cast/screen/screendefaultvideo"
    
    static let Bucket_Path_Caster_DefaultImage      = "control-cast/cast/castimage"
    static let Bucket_Path_Caster_DefaultVideo      = "control-cast/cast/castvideo"
    
    
    
    //TWITTER - OpenXcell account
    //static let kConsumerKeyTwitter:    String = "qWuig9JT70VBjvuHwjf2M8oEy"
    //static let kConsumerSecretTwitter: String = "jZxDDxbpBhBH8mmWLqhcwytY2OJd9dMfF0y05L1LeIrTbSpHfz"
    
    //TWITTER - Client account
    static let kConsumerKeyTwitter:    String = "6KzqDvcgiMslk2QFgSQGQXBwD"
    static let kConsumerSecretTwitter: String = "aO1L7rLRxYHlevedM5oppyXym5BkuhHP9UJR5zmEjyhV4ZORnP"
    
    //Google Place API
    //static let kGoogle_Places_API: String = "AIzaSyD2nEr0slet_u3i3l2R4mF4_hmOUms5bZg"
    static let kGoogle_Places_API: String = "AIzaSyAS2p9b9mJ1eE1PXiVbFR9e9PEg9I6IfGY"
    
    //Stripe API Key
    //static let kStripe_API: String = "pk_test_UyNsLrjsm3GUlp4ryetV6Ilk" //MeHuLa
    //static let kStripe_API: String = "pk_test_ayhqSGtQKeg96nBmmEuG1Ks0" //Client - Sandbox
    static let kStripe_API: String = "pk_live_67tZ0NfMdCOts5vayH273jgp" //Client - Live
    
    //URLs
    static let TERMS_OF_USE_URL   = "https://www.google.com"
    static let PRIVACY_POLICY_URL = "https://www.google.com"
    
    //Player App - App Store Link
    static let APPSTORE_PLAYER_APP = ""
    
    //Powered By
    static let POWERED_BY           = "Powered by Controlcast"
    
    
    
    //MARK: - Fonts
    struct Fonts {
        static let Roboto_Light             = "Roboto-Light"
        static let Roboto_Regular           = "Roboto-Regular"
        static let Roboto_Bold              = "Roboto-Bold"
        static let Roboto_Medium            = "Roboto-Medium"
    }
    
    //MARK: - Fonts
    struct HomeOption {
        static let Workouts                     = 0
        static let Workout_Programs             = 1
        static let Circuit_Superset             = 2
        static let Stretch_And_Yoga_Library     = 3
        static let Exercise_And_WarmUp_Library  = 4
        static let Calculator_And_Tool          = 5
        static let Calender                     = 6
        static let Strong_Charity               = 7
        static let Social                       = 8
    }
    
    
    //MARK: - Storyboards
    struct StoryBoardFile {
        //static let MAIN         = "Main"
        static let MAIN_STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
    }
    
    //MARK: - Storyboard Identifier
    struct StoryBoardIdentifier {
        //Caster
        static let LANDING_PAGE             = "LandingPage"
        static let VENUE_DETAIL             = "VenueDetail"
        static let HOME                     = "Home"
        static let MY_CART                  = "MyCart"
        static let CHECKOUT                 = "Checkout"
        static let SEARCH                   = "Search"
        static let ORDER_CONFIRMATION       = "OrderConfirmation"
        static let CARD_INFORMATION         = "CardInformation"
        static let RESTAURANTS              = "Restaurants"
        static let MY_ORDERS                = "MyOrders"
        static let ORDER_INFORMATION        = "OrderInformation"
    }
    
    
    //VIDEO SIZE
    static let VIDEO_MIN_LENGTH = 3
    static let VIDEO_MAX_SIZE   = 15 //30 //50
    static let VIDEO_MAX_LENGTH = 30 //60
    
    
    //Validations
    static let PASSWORD_LIMIT = 6
    
    //Alert Messages
    static let MESSAGE_WORKOUT_NAME         = "Please enter workout name."
    
    static let MESSAGE_USER_NAME            = "Please enter your name to continue."
    static let MESSAGE_EMAIL                = "Please enter your valid email address to continue."
    static let MESSAGE_PASSWORD             = "Please enter your password. Passwords must be at least 6 characters."
    static let MESSAGE_PASSWORD_LIMIT       = "Password must have at least 6 characters."
    static let MESSAGE_CONFIRM_PASSWORD_LIMIT       = "Re-enter password must have at least 6 characters."
    static let MESSAGE_PASSWORD_WRONG       = "Please enter correct password"
    static let MESSAGE_EMAIL_VALID          = "Please enter a valid email."
    static let MESSAGE_COUNTRY_BLANK        = "Please select country to continue."
    
    static let MESSAGE_CASTER_MESSAGE       = "Please login with caster account"
    static let MESSAGE_PARTNER_MESSAGE      = "Please login with partner account"
    
    //Screen Login
    static let MESSAGE_CONFIRM_PASSWORD     = "Please provide confirm password."
    //static let MESSAGE_NO_MATCH_PASSWORD    = "Passwords do not match, please re-enter."
    static let MESSAGE_NO_MATCH_PASSWORD    = "Passwords entered do not match."
    static let MESSAGE_NO_MATCH_PASSWORDS   = "New password and confirm password don’t match."

    
    //Logout
    static let kLOGOUT                  = "Logout"
    static let MESSAGE_LOGOUT           = "Are you sure you want to logout?"
    
    //Cancel
    static let kCANCEL                  = "Cancel"
    static let kOK                      = "OK"
    
    //Cast Detail
    static let MESSAGE_DELETE_CAST      = "Are you sure you want to delete this cast?"
    static let MESSAGE_DELETE_SCREEN    = "Are you sure you want to permanently delete this Screen?"
    
    //Partner - Register Screen
    static let MESSAGE_PHOTO            = "Please select at least one image for your screen."
    static let MESSAGE_LOCATION_NAME    = "Please enter the Location Name."
    static let MESSAGE_INDUSTRY         = "Please select industry type."
    static let MESSAGE_SCREEN           = "Please select screen type."
    static let MESSAGE_DIMENSION        = "Please select dimension."
    static let MESSAGE_ORIENATATION     = "Please select orientation type."
    static let MESSAGE_DAYS_OF_OPERATION     = "Please select days of operation."
    static let MESSAGE_LOCATION         = "Please select location type."
    static let MESSAGE_LOCATION_OTHER   = "Please input location type."
    static let MESSAGE_SOUND_AVAILABILITY     = "Please select sound availability option."
    static let MESSAGE_GENERAL_DESC     = "Please enter a general description of your screen and location."
    static let MESSAGE_SUPPORT_DOCS     = "Please select at least one image for your supporting document."
    static let MESSAGE_ADDRESS          = "Please select Map location."
    static let MESSAGE_COUNTRY          = "Please select country."
    static let MESSAGE_STATE            = "Please select state."
    static let MESSAGE_CITY             = "Please select city."
    
    //SELECT SCREEN
    static let MESSAGE_SELECT_ANY_SCREEN_OPTION = "Please select an option to proceed."
    
    //VIDEO Constraints
    //static let MESSAGE_VIDEO_SIZE       = "Video size should less than 50 mb."
    //static let MESSAGE_VIDEO_MIN_LENGTH = "Video length should more than 3 seconds."
    //static let MESSAGE_VIDEO_MAX_LENGTH = "Video length should less than 60 seconds."
    
    static let MESSAGE_VIDEO_SIZE       = "Please select a supported file type that is up to \(VIDEO_MAX_LENGTH) seconds in length and \(VIDEO_MAX_SIZE) MB in size."
    static let MESSAGE_VIDEO_MIN_LENGTH = "Please select a supported file type that is up to \(VIDEO_MAX_LENGTH) seconds in length and \(VIDEO_MAX_SIZE) MB in size."
    static let MESSAGE_VIDEO_MAX_LENGTH = "Please select a supported file type that is up to \(VIDEO_MAX_LENGTH) seconds in length and \(VIDEO_MAX_SIZE) MB in size."
    
    //Credit
    static let MESSAGE_CREDIT_AMOUNT    =   "Please provide amount to credit."
    
    //Referral Code
    static let MESSAGE_EMPTY_REFERRAL_CODE = "Please provide referral code."
    
    //Summary
    static let MESSAGE_NO_BALANCE       = "Insufficient balance, please add credit or modify the cast request to proceed."
    
    //ToolTip Message
    //Supporting Documents
    //static let TOOLTIP_MESSAGE_SUPPORTING_DOCUMENTS = "To help us verify your account, please provide scans of \nany relevant supporting documents that prove your legal \nownership of the location and/or official authorizing \nletter from your company. \nAlternatively you can email the files directly to support@controlcastapp.com."
    //MeHuLa, 3 October 2017
    //Changed by Client
    static let TOOLTIP_MESSAGE_SUPPORTING_DOCUMENTS = "To help us validate your account, please provide images of relevant business licenses, legal documents, or other proof to show you are authorized to offer advertising services in this specific location."
    
    static let TOOLTIP_MESSAGE_DEFAULT_VIDEO = "You can upload your own cast promoting your business, screen display, etc. The cast will play automatically alongside other scheduled casts."
    
    
    static let UserDefault = UserDefaults.standard
    struct UserDefaultConstant {
        static let userAccessToken = "accessToken"
        static let userId = "userId"
        static let userFullName = "userName"
        static let userImage = "userImage"
        static let deviceToken = "deviceToken"
        static let userEmailAddress = "userEmailAddress"
        static let userPassword = "userPassword"
        static let profileImg = "profileImg"
        
        static let userProfileInfo = "userProfileInfo"
        static let userLoggedIn = "isLogin"
        static let userKey = "key"

    }
}

//MARK: - Check device is SIMULATOR
extension UIDevice {
    static var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
}

//Check App flow is for Caster or Parter
struct Colors {
    static let YELLOW  = UIColor(red: 231/255.0, green: 231/255.0, blue: 48/255.0, alpha: 1.0)
    static let BLACK   = UIColor(red: 26/255.0, green: 26/255.0, blue: 26/255.0, alpha: 1.0)
    static let MAROON  = UIColor(red: 161/255.0, green: 55/255.0, blue: 36/255.0, alpha: 1.0)
}

//Check Screen Status
struct ScreenStatus {
    static let Approved  = "approved"
    static let Rejected  = "rejected"
    static let Pending   = "pending"
}

//Card Type
struct CardType {
    static let Visa         = "Visa"
    static let MasterCard   = "MasterCard"
    static let Unknown      = "card"
}


