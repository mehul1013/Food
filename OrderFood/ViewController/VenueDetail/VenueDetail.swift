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
    
    
    //MARK: - View Online Menu
    @IBAction func btnViewMenuClicked(_ sender: Any) {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.HOME) as! Home
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
                let dict = response?.formattedData as! VenueInfo
                print("Cart from Web = \(dict)")
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
