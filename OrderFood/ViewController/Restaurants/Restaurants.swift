//
//  Restaurants.swift
//  OrderFood
//
//  Created by MehulS on 15/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class Restaurants: SuperViewController {

    @IBOutlet weak var collectionViewRestaurant: UICollectionView!
    
    var strTitle: String = ""
    var strVenueID: String = ""
    
    var restaurant = [RestaurantModel]()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "\(strTitle)"
        
        //Get Restaurants
        self.getRestaurants()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Order Online Button
    func btnOrderOnlineClicked(_ sender: UIButton) -> Void {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.HOME) as! Home
        
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}


//MARK: - UICollectionView Delegates
extension Restaurants: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.restaurant.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellRestaurant", for: indexPath) as! CellRestaurant
        
        //Get Model
        let model = self.restaurant[indexPath.row]
        
        //Set Data
        if model.imageUrl.contains("https") {
            let url = URL(string: model.imageUrl)
            cell.imageViewRestaurant.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
        }else {
            let url = URL(string: "https:" + model.imageUrl)
            cell.imageViewRestaurant.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
        }
        
        cell.lblVenueName.text = model.name
        //cell.lblRating.text = model.
        
        if model.cuisineArray.count <= 0 {
            cell.lblCuisine.text = "N/A"
        }else {
            cell.lblCuisine.text = model.cuisineArray
        }
        
        if model.avgCost == 0 {
            cell.lblAverageCost.text = "N/A"
        }else {
            cell.lblAverageCost.text = "\(model.avgCost)"
        }
        
        if model.offer == "" {
            cell.lblOffer.text = "N/A"
        }else {
            cell.lblOffer.text = model.offer
        }
        
        //Add Target
        cell.btnOrderOnline.tag = indexPath.row
        cell.btnOrderOnline.addTarget(self, action: #selector(btnOrderOnlineClicked(_:)), for: .touchUpInside)
        
        return cell
    }
}


//MARK: - Web Services
extension Restaurants {
    
    //MARK: - Get Venue Information
    func getRestaurants() -> Void {
        
        RestaurantModel.getRestaurants(strVenueID: self.strVenueID, showLoader: true) { (isSuccess, response, error) in
            if isSuccess == true {
                //Get Data
                self.restaurant = response?.formattedData as! [RestaurantModel]
                print("Restaurant from Web = \(self.restaurant)")
                
                //Set Data
                DispatchQueue.main.async {
                    self.collectionViewRestaurant.reloadData()
                }
                
            }else {
            }
        }
    }
}
