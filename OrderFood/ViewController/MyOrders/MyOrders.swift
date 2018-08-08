//
//  MyOrders.swift
//  OrderFood
//
//  Created by MehulS on 29/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class MyOrders: SuperViewController {

    @IBOutlet weak var collectionViewMyOrders: UICollectionView!
    
    @IBOutlet weak var btnCurrentOrder: UIButton!
    @IBOutlet weak var btnPastOrder: UIButton!
    @IBOutlet weak var lblSeparator: UILabel!
    @IBOutlet weak var constraintLeading_Separator: NSLayoutConstraint!
    
    var arrayCurrentOrders = [MyOrderModel]()
    var arrayPastOrders = [MyOrderModel]()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "My Orders"
        
        //Get Current Orders
        self.getCurrentOrders()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIButton Actions
    @IBAction func btnCurrentOrderClicked(_ sender: Any) {
        //Animate Separator
        self.constraintLeading_Separator.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnPastOrderClicked(_ sender: Any) {
        //Animate Separator
        let value = UIScreen.main.bounds.size.width / 2
        self.constraintLeading_Separator.constant = value
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}


//MARK: - UICollectionView Methods
extension MyOrders: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 280)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayCurrentOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMyOrder", for: indexPath) as! CellMyOrder
        
        //Get Model
        let model = self.arrayCurrentOrders[indexPath.row]
        
        //Set Data
        if model.kitchenLogo.contains("https") {
            let url = URL(string: model.kitchenLogo)
            cell.imageViewLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
        }else {
            let url = URL(string: "https:" + model.kitchenLogo)
            cell.imageViewLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
        }
        
        cell.lblVenueName.text = model.kitchenName
        cell.lblSeatNumber.text = "Seat No: \(model.rowName) - \(model.seatName)"
        cell.lblOrderDate.text = model.orderDate
        cell.lblTotalAmount.text = "$\(model.totalAmount)"
        
        return cell
    }
}


//MARK: - Web Services
extension MyOrders {
    //MARK: - Get Current Orders
    func getCurrentOrders() -> Void {
        MyOrderModel.getCurrentOrders(strVenueID: "1", showLoader: true) { (isSuccess, response, error) in
            if isSuccess == true {
                //Get Data
                self.arrayCurrentOrders = response?.formattedData as! [MyOrderModel]
                print("Current Orders = \(self.arrayCurrentOrders)")
                
                //Set Data
                DispatchQueue.main.async {
                    self.collectionViewMyOrders.reloadData()
                }
                
            }else {
            }
        }
    }
    
    
    //MARK: - Get Past Orders
    func getPastOrders() -> Void {
        
    }
}
