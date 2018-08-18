//
//  MyOrders.swift
//  OrderFood
//
//  Created by MehulS on 29/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class MyOrders: SuperViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionViewMyOrders: UICollectionView!
    @IBOutlet weak var collectionViewPastOrders: UICollectionView!
    @IBOutlet weak var constraintLeading_PastOrder_CollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var btnCurrentOrder: UIButton!
    @IBOutlet weak var btnPastOrder: UIButton!
    @IBOutlet weak var lblSeparator: UILabel!
    @IBOutlet weak var constraintLeading_Separator: NSLayoutConstraint!
    
    var arrayCurrentOrders = [MyOrderModel]()
    var arrayPastOrders = [MyOrderModel]()
    
    var isCurrentOrderScreen: Bool = true
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "My Orders"
        
        //Set Delegate
        self.scrollView.delegate = self
        
        //Get Current Orders
        self.getCurrentOrders()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //ScrollView
        scrollView.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width * 2, height: self.scrollView.frame.size.height)
        
        constraintLeading_PastOrder_CollectionView.constant = UIScreen.main.bounds.size.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIButton Actions
    @IBAction func btnCurrentOrderClicked(_ sender: Any) {
        //Animate Separator
        self.constraintLeading_Separator.constant = 0
        
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        if arrayCurrentOrders.count <= 0 {
            self.getCurrentOrders()
        }else {
            self.collectionViewMyOrders.reloadData()
        }
    }
    
    @IBAction func btnPastOrderClicked(_ sender: Any) {
        //Animate Separator
        let value = UIScreen.main.bounds.size.width / 2
        self.constraintLeading_Separator.constant = value
        
        self.scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.size.width, y: 0), animated: true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        }) { (isCompleted) in
        }
        
        if arrayPastOrders.count <= 0 {
            self.getPastOrders()
        }else {
            self.collectionViewPastOrders.reloadData()
        }
    }
    
    
    func btnOrderNumberClicked(_ sender: UIButton) -> Void {
        //Navigate to Order Information
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.ORDER_INFORMATION) as! OrderInformation
        
        //Get Model
        var model: MyOrderModel!
        if self.isCurrentOrderScreen == true {
            model = self.arrayCurrentOrders[sender.tag]
        }else {
            model = self.arrayPastOrders[sender.tag]
        }
        
        //Pass Data
        viewCTR.strOrderID = model.id
        
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}


//MARK: - UIScrollView Methods
extension MyOrders: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        
        print("Content Offset : \(scrollView.contentOffset.x)")
        print("Page : \(page)")
        
        if page == 0 && scrollView.contentOffset.x == 0 {
            //Current Order
            isCurrentOrderScreen = true
            
            //Change Separator
            self.constraintLeading_Separator.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            if arrayCurrentOrders.count <= 0 {
                self.getCurrentOrders()
            }else {
                self.collectionViewMyOrders.reloadData()
            }
        }else if page == 1 && scrollView.contentOffset.x == UIScreen.main.bounds.width {
            //Past Order
            isCurrentOrderScreen = false
            
            //Change Separator
            self.constraintLeading_Separator.constant = UIScreen.main.bounds.width / 2
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            if arrayPastOrders.count <= 0 {
                self.getPastOrders()
            }else {
                self.collectionViewPastOrders.reloadData()
            }
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
        if self.isCurrentOrderScreen == true {
            return self.arrayCurrentOrders.count
        }
        return self.arrayPastOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMyOrder", for: indexPath) as! CellMyOrder
        
        //Get Model
        var model: MyOrderModel!
        if self.isCurrentOrderScreen == true {
            model = self.arrayCurrentOrders[indexPath.row]
        }else {
            model = self.arrayPastOrders[indexPath.row]
        }
        
        //Set Data
        if model.kitchenLogo.contains("https") {
            let url = URL(string: model.kitchenLogo)
            cell.imageViewLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
        }else {
            let url = URL(string: "https:" + model.kitchenLogo)
            cell.imageViewLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
        }
        
        //Order Status
        /*if model.orderStatus.lowercased() == "" {
            //Ordered
            cell.imageViewOrderStatus.image = UIImage(named: "")
        }else*/ if model.orderStatus.lowercased() == "new" {
            //Confirmed
            cell.imageViewOrderStatus.image = UIImage(named: "Order1")
        }else if model.orderStatus.lowercased() == "preparing" {
            //Preparing
            cell.imageViewOrderStatus.image = UIImage(named: "Order3")
        }else if model.orderStatus.lowercased() == "onway" {
            //On Way
            cell.imageViewOrderStatus.image = UIImage(named: "Order3")
        }else /*if model.orderStatus.lowercased() == ""*/ {
            //Delivered
            cell.imageViewOrderStatus.image = UIImage(named: "Order4")
        }
        
        cell.lblVenueName.text = model.kitchenName
        cell.lblSeatNumber.text = "Seat No: \(model.rowName) - \(model.seatName)"
        cell.lblOrderDate.text = model.orderDate
        cell.lblTotalAmount.text = "$\(model.totalAmount)"
        
        cell.btnOrderNumber.setTitle("Order Number : \(model.orderNumber)", for: .normal)
        
        //Add Target
        cell.btnOrderNumber.tag = indexPath.row
        cell.btnOrderNumber.addTarget(self, action: #selector(btnOrderNumberClicked), for: .touchUpInside)
        
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
        MyOrderModel.getPastOrders(strVenueID: "1", showLoader: true) { (isSuccess, response, error) in
            if isSuccess == true {
                //Get Data
                self.arrayPastOrders = response?.formattedData as! [MyOrderModel]
                print("Past Orders = \(self.arrayCurrentOrders)")
                
                //Set Data
                DispatchQueue.main.async {
                    self.collectionViewPastOrders.reloadData()
                }
                
            }else {
            }
        }
    }
}
