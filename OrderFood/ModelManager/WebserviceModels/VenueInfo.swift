//
//  VenueInfo.swift
//  OrderFood
//
//  Created by MehulS on 08/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import ObjectMapper

class VenueInfo: Mappable {
    
    internal var promoterId         : Int = 0
    internal var venueId            : Int = 0
    internal var theaterId          : Int = 0
    internal var levelId            : Int = 0
    internal var sectionId          : Int = 0
    internal var rowId              : Int = 0
    internal var seatId             : Int = 0
    internal var name               : String = ""
    internal var avgMinsToDeliver   : Int = 0
    internal var minOrder           : Double = 0.0
    internal var rating             : Int = 0
    internal var seatName           : String = ""
    internal var logo               : String = ""
    internal var imageUrl           : String = ""
    internal var address            : String = ""
    
    init() {
    }
    
    class var mapperObj : Mapper<VenueInfo>  {
        let mapper : Mapper = Mapper<VenueInfo>()
        return mapper
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        promoterId          <- map["promoterId"]
        venueId             <- map["venueId"]
        theaterId           <- map["theaterId"]
        levelId             <- map["levelId"]
        sectionId           <- map["sectionId"]
        rowId               <- map["rowId"]
        seatId              <- map["seatId"]
        name                <- map["name"]
        avgMinsToDeliver    <- map["avgMinsToDeliver"]
        minOrder            <- map["minOrder"]
        rating              <- map["rating"]
        seatName            <- map["seatName"]
        logo                <- map["logo"]
        imageUrl            <- map["imageUrl"]
        address             <- map["address"]
    }
    
    
    //MARK: - Get Cart
    class func getVenueInfo(strQRCode: String, showLoader: Bool, completionHandler:@escaping ((Bool?, WebServiceReponse?, Error?) -> Void)) {
        
        //Make URL
        var strURL = WS_GET_VENUE_INFO + "\(strQRCode).json" // + (uuid?.uuidString)!
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(strURL)
        
        WebSerivceManager.GETRequest(url: strURL, showLoader: showLoader) { (isSuccess, response, error) in
            if isSuccess == false {
                completionHandler(isSuccess, nil, error)
            }else {
                
                let dictionary = self.mapperObj.map(JSON: response?.data as! [String : Any]) //self.mapperObj.mapArray(JSONArray: [response?.data as! [String : Any]])
                response?.formattedData = dictionary as AnyObject?
                
                completionHandler(isSuccess, response, error)
            }
        }
    }
}
