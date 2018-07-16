//
//  VenueDetail.swift
//  OrderFood
//
//  Created by MehulS on 05/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class VenueDetail: SuperViewController {
    
    @IBOutlet weak var imageViewVenue: UIImageView!
    @IBOutlet weak var lblVenueName: UILabel!
    @IBOutlet weak var lblVenueAddress: UILabel!
    
    @IBOutlet weak var lblAvgTimeToDeliver: UILabel!
    @IBOutlet weak var lblMinOrder: UILabel!
    //@IBOutlet weak var lblAvgTimeToDeliver: UILabel!
    
    @IBOutlet weak var lblScreenID: UILabel!
    @IBOutlet weak var lblSeatID: UILabel!
    
    @IBOutlet weak var lblMinOrderStatic: UILabel!
    
    var venue: VenueInfo!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Get Venue Information
        self.getVenueInformation()
        
        //Get Cart, if available
        //self.getCart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Show Navigation Bar
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Set Venue Information
    func setVenueInformation() -> Void {
        //Set Image
        if venue.imageUrl.contains("https") {
            let url = URL(string: venue.imageUrl)
            self.imageViewVenue.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
        }else {
            let url = URL(string: "https:" + venue.imageUrl)
            self.imageViewVenue.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
        }
        
        lblVenueName.text = venue.name
        lblVenueAddress.text = venue.address
        
        lblAvgTimeToDeliver.text = "\(venue.avgMinsToDeliver) Min"
        lblMinOrder.text = "\(venue.minOrder)"
        
        lblScreenID.text = "Screen - \(venue.seatId)"
        lblSeatID.text = venue.seatName
        
        lblMinOrderStatic.text = "Minimum order for this seat is \(venue.minOrder)"
    }
 
    
    //MARK: - View Online Menu
    @IBAction func btnViewMenuClicked(_ sender: Any) {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.RESTAURANTS) as! Restaurants
        
        //Pass Data
        viewCTR.strTitle = venue.name
        viewCTR.strVenueID = "\(venue.venueId)"
        
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}

//MARK: - Web Services
extension VenueDetail {
    
    //MARK: - Get Venue Information
    func getVenueInformation() -> Void {
        VenueInfo.getVenueInfo(showLoader: true) { (isSuccess, response, error) in
            if isSuccess == true {
                //Get Data
                self.venue = response?.formattedData as! VenueInfo
                print("Cart from Web = \(self.venue)")
                
                //Set Data
                DispatchQueue.main.async {
                    self.setVenueInformation()
                }
                
            }else {
            }
        }
    }
    
    
    //MARK: - Get All Categories
    func getCart() -> Void {
        
        CartModel.getCart(showLoader: true) { (isSuccess, response, error) in
            
            if isSuccess == true {
                //Get Data
                let array = response?.formattedData as! [CartModel]
                print("Cart from Web = \(array)")
                
                //First clear cart
                AppUtils.APPDELEGATE().arrayCart.removeAll()
                
                //Get Cart value into local object of Cart
                for item in array {
                    let cart = Cart()
                    
                    cart.itemID = item.ItemID
                    cart.itemName = item.ItemName
                    cart.numberOfItem = item.Qty
                    cart.price = item.ItemPrice
                    cart.isItemModified = false
                    
                    AppUtils.APPDELEGATE().arrayCart.append(cart)
                }
                
            }else {
            }
        }
    }
}
