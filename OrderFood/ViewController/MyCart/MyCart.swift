//
//  MyCart.swift
//  OrderFood
//
//  Created by Mehul Solanki on 08/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class MyCart: SuperViewController {
    
    @IBOutlet weak var tableViewMyCart: UITableView!
    @IBOutlet weak var btnCheckout: UIButton!
    
    var count = AppUtils.APPDELEGATE().arrayCart.count
    var total = 0.00
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "My Cart"
        
        //Remove extra lines from UITableView
        self.tableViewMyCart.tableFooterView = UIView(frame: CGRect.zero)
        
        //Get Total and Sub-totle
        self.getTotalOfAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Get Total of Items from Cart
    func getTotalOfAllItems() -> Void {
        //First assign 0 to TOTAL
        total = 0.0
        
        for item in AppUtils.APPDELEGATE().arrayCart {
            let numberOfItemDouble = Double(item.numberOfItem!)
            total = total + (numberOfItemDouble * item.price!)
        }
        
        //Checkout Button
        self.btnCheckout.setTitle("Checkout ($\(total))", for: .normal)
    }
    
    
    //MARK: - Plus Item to Cart
    func btnPlusItemClicked(_ sender: UIButton) -> Void {
        //Get Model
        let model = AppUtils.APPDELEGATE().arrayCart[sender.tag]
        
        //Get number of items and increase NUMBER OF ITEMS in CART
        var numberOfItems = model.numberOfItem
        numberOfItems = numberOfItems! + 1
        
        //Assign new value to cart
        model.numberOfItem = numberOfItems
        model.isItemModified = true
        
        //Get Total and Sub-totle
        self.getTotalOfAllItems()
        
        //Reload UITableView
        self.tableViewMyCart.reloadData()
        
        //Update Flag
        AppUtils.APPDELEGATE().isAnyChangeInCart = true
        
        //Post Observer
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ManageCartView"), object: nil)
    }
    
    //MARK: - Minus Item to Cart
    func btnMinusItemClicked(_ sender: UIButton) -> Void {
        //Get Model
        let model = AppUtils.APPDELEGATE().arrayCart[sender.tag]
        
        //Get number of items
        var numberOfItems = model.numberOfItem!
        numberOfItems = numberOfItems - 1
        
        //If it is getting 0 or less, make it 0
        if numberOfItems <= 0 {
            numberOfItems = 0
            
            //Remove item from Cart with web service
            self.removeItemFromCart(model.itemID!)
        }
        
        //Assign new value to cart
        model.numberOfItem = numberOfItems
        model.isItemModified = true
        
        //if it gets 0, remove from CART
        if numberOfItems <= 0 {
            //If any item get 0, do not include it in CART MODEL
            let arrayTemp = AppUtils.APPDELEGATE().arrayCart
            
            //Remove Global CART MODEL
            AppUtils.APPDELEGATE().arrayCart.removeAll()
            
            for cart in arrayTemp {
                if cart.numberOfItem! <= 0 {
                    //Do Nothing
                }else {
                    //Add to CART
                    AppUtils.APPDELEGATE().arrayCart.append(cart)
                }
            }
            
            //Update CART COUNT
            count = AppUtils.APPDELEGATE().arrayCart.count
        }else {
            //In else closure because no need to make flag true when it comes to delete item from cart from local as well as API
            //Update Flag
            AppUtils.APPDELEGATE().isAnyChangeInCart = true
        }
        
        //Get Total and Sub-totle
        self.getTotalOfAllItems()
        
        //Reload UITableView
        self.tableViewMyCart.reloadData()
        
        //Post Observer
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ManageCartView"), object: nil)
    }
    
    
    //MARK: - Checkout
    @IBAction func btnCheckoutClicked(_ sender: Any) {
        //If any item added or deleted to cart, update through web service
        if AppUtils.APPDELEGATE().isAnyChangeInCart == true {
            //Call Web Service to Update Cart
            self.updateCart()
        }else {
            self.navigateToCheckout()
        }
    }
    
    
    //MARK: - Navigate to next screen
    func navigateToCheckout() -> Void {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.CHECKOUT) as! Checkout
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}

//MARK: - UITableView Methods
extension MyCart: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count+1+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < count {
            return 60
        }else {
            return 115
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CellMyCart
            
        if indexPath.row < count {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellMyCartItem") as! CellMyCart
            
            //Get model of CART
            let model = AppUtils.APPDELEGATE().arrayCart[indexPath.row]
            
            //Set Data
            cell.lblItemName.text = model.itemName
            cell.lblNumberOfItem.text = "\(model.numberOfItem!)"
            
            let numberOfItemDouble = Double(model.numberOfItem!)
            cell.lblPrice.text = "$\((numberOfItemDouble * model.price!))"
            //cell.lblPrice.text = "$\(model.numberOfItem! * model.price!)"
            
            //UIbutton Action
            cell.btnPlus.tag = indexPath.row
            cell.btnPlus.addTarget(self, action: #selector(btnPlusItemClicked), for: .touchUpInside)
            
            cell.btnMinus.tag = indexPath.row
            cell.btnMinus.addTarget(self, action: #selector(btnMinusItemClicked), for: .touchUpInside)
            
        }else if indexPath.row == count {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellTotal") as! CellMyCart
            
            //Set Data
            cell.lblSubTotal.text = "$\(total)"
            cell.lblGrandTotal.text = "$\(total)"
            
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellSpecialInstruction") as! CellMyCart
        }
        
        cell.selectionStyle = .none
        return cell
    }
}


//MARK: - Web Services
extension MyCart {
    //MARK: - Remove Item from Cart
    func removeItemFromCart(_ itemID: Int) -> Void {
        
        CartModel.deleteItemCart(itemID: itemID, showLoader: true) { (isSuccess, response, error) in
            if isSuccess == true {
                //Success, there is no data getting in response
            }else {
            }
        }
    }
    
    
    //MARK: - Update Cart
    func updateCart() -> Void {
        
        //Initialise Array
        let arrayModifiedCart = NSMutableArray()
        
        let uuid = AppUtils.APPDELEGATE().guid
        
        //Get Modified Array
        for cart in AppUtils.APPDELEGATE().arrayCart {
            //If item modified then only update through web service
            if cart.isItemModified == true {
                var dictTemp = [String : AnyObject]()
                
                dictTemp["GuId"]        = uuid as AnyObject
                dictTemp["discountId"]  = 0 as AnyObject
                dictTemp["ItemID"]      = cart.itemID as AnyObject
                dictTemp["itemName"]    = cart.itemName as AnyObject
                dictTemp["itemPrice"]   = cart.price as AnyObject
                dictTemp["Qty"]         = cart.numberOfItem as AnyObject
                dictTemp["tax"]         = 0 as AnyObject
                
                arrayModifiedCart.add(dictTemp)
                
                //Update Global Cart Modified value, so next time if there is no change, it will not call web service
                cart.isItemModified = false
            }
        }
        
        //If there is nothing to update in ARRAY, no need to call WS
        if arrayModifiedCart.count <= 0 {
            //Update Flag
            AppUtils.APPDELEGATE().isAnyChangeInCart = false
            
            //Navigate to next screen
            self.navigateToCheckout()
        }else {
            
            CartModel.createCart(arrayItems: arrayModifiedCart, showLoader: true) { (isSuccess, response, error) in
                
                if isSuccess == true {
                    //Success, there is no data getting in response
                    
                    //Update Flag
                    AppUtils.APPDELEGATE().isAnyChangeInCart = false
                    
                    //Navigate to next screen
                    self.navigateToCheckout()
                    
                }else {
                }
            }
        }
    }
}
