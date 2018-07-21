//
//  Search.swift
//  OrderFood
//
//  Created by MehulS on 17/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class Search: SuperViewController {

    @IBOutlet weak var tableViewItems: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    var arrayItems = [SearchItem]()
    @IBOutlet weak var constraintBottom_TableView: NSLayoutConstraint!
    
    var arrayCartItem = [Int]()
    var isCartModified: Bool = false
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Search"
        
        //Get Items from CART, if any
        self.getItemsFromCart()
        
        //Bottom Padding
        tableViewItems.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
        //Register Cell
        tableViewItems.register(UINib(nibName: "CellItem", bundle: nil), forCellReuseIdentifier: "CellTemp")
        
        //When KEYBOARD Appear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        //When KEYBOARD Disappear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Open Keyboard
        self.txtSearch.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Check it is pop view controller
        if isMovingFromParentViewController && self.isCartModified == true {
            //Post Observer
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateModelRegardingCart"), object: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Get Items from Cart
    func getItemsFromCart() -> Void {
        //First remove selected items from ARRAy
        self.arrayCartItem.removeAll()
        
        if AppUtils.APPDELEGATE().arrayCart.count > 0 {
            for item in AppUtils.APPDELEGATE().arrayCart {
                self.arrayCartItem.append(item.itemID!)
            }
        }
    }
    
    
    //MARK: - UIKeyboard Methods
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            
            self.constraintBottom_TableView.constant = keyboardHeight
            self.tableViewItems.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.constraintBottom_TableView.constant = 0
        self.tableViewItems.layoutIfNeeded()
    }
    
    //MARK: - Add Item
    func btnAddItemClicked(_ sender: UIButton) -> Void {
        //Get Cell
        if let _ = self.tableViewItems.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? CellItem {
            
            //Add item to Cart
            //Get Model
            let model = self.arrayItems[sender.tag]
            model.numberOfItem = 1
            
            //Add New Cart
            let cart = Cart()
            cart.itemID = model.id
            cart.itemName = model.name
            cart.numberOfItem = 1
            cart.price = model.amount
            cart.isItemModified = true
            
            AppUtils.APPDELEGATE().arrayCart.append(cart)
            
            //Update Selected ItemID
            self.arrayCartItem.append(model.id)
            
            //Check if need to show Cart View
            if AppUtils.APPDELEGATE().arrayCart.count <= 0 {
                //Post Observer
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ManageCartView"), object: nil)
            }
            
            //Update Flag
            self.isCartModified = true
            
            //Update Flag
            AppUtils.APPDELEGATE().isAnyChangeInCart = true
            
            //Reload Cell
            self.tableViewItems.reloadData()
        }
    }
    
    //MARK: - Plus Item to Cart
    func btnPlusItemClicked(_ sender: UIButton) -> Void {
        //Get Model
        let model = self.arrayItems[sender.tag]
        
        //Get number of items
        var numberOfItems = model.numberOfItem
        
        //Check and increase NUMBER OF ITEMS in CART
        for item in AppUtils.APPDELEGATE().arrayCart {
            if item.itemID == model.id {
                numberOfItems = numberOfItems + 1
                
                //Assign new value to cart
                item.numberOfItem = numberOfItems
                item.isItemModified = true
                
                //Assign new value to model
                model.numberOfItem = numberOfItems
                
                //Update Flag
                self.isCartModified = true
                
                //Reload UITableView
                self.tableViewItems.reloadData()
            }
        }
        
        //Update Flag
        AppUtils.APPDELEGATE().isAnyChangeInCart = true
        
        //Post Observer
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ManageCartView"), object: nil)
    }
    
    //MARK: - Minus Item to Cart
    func btnMinusItemClicked(_ sender: UIButton) -> Void {
        //Get Model
        let model = self.arrayItems[sender.tag]
        
        //Get number of items
        var numberOfItems = model.numberOfItem
        
        //Check and increase NUMBER OF ITEMS in CART
        for item in AppUtils.APPDELEGATE().arrayCart {
            if item.itemID == model.id {
                numberOfItems = numberOfItems - 1
                
                //If it is getting 0 or less, make it 0
                if numberOfItems <= 0 {
                    numberOfItems = 0
                    
                    //Remove item from Cart with web service
                    self.removeItemFromCart(item.itemID!)
                }
                
                //Assign new value to cart
                item.numberOfItem = numberOfItems
                item.isItemModified = true
                
                //Assign new value to model
                model.numberOfItem = numberOfItems
                
                //if it gets 0, remove from CART
                if numberOfItems <= 0 {
                    let index = AppUtils.APPDELEGATE().arrayCart.index(of: item)
                    AppUtils.APPDELEGATE().arrayCart.remove(at: index!)
                    
                    //Get Items from CART, if any
                    self.getItemsFromCart()
                }else {
                    //In else closure because no need to make flag true when it comes to delete item from cart from local as well as API
                    //Update Flag
                    AppUtils.APPDELEGATE().isAnyChangeInCart = true
                }
                
                //Update Flag
                self.isCartModified = true
                
                //Reload UITableView
                self.tableViewItems.reloadData()
            }
        }
        
        //Update Flag
        AppUtils.APPDELEGATE().isAnyChangeInCart = true
        
        //Post Observer
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ManageCartView"), object: nil)
    }
}


//MARK: - UITextField Methods
extension Search: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            print(updatedText)
            
            //Call WS if search string is more than 2 chars
            if updatedText.count >= 2 {
                self.searchItem(updatedText)
            }else {
                self.arrayItems.removeAll()
                self.tableViewItems.reloadData()
            }
        }
        return true
    }
}


//MARK: - UITableView Delegates
extension Search: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CellTemp
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTemp") as! CellItem
        
        //Get Model
        let model = self.arrayItems[indexPath.row]
        
        //Set Data
        cell.lblName.text = model.name
        cell.lblPrice.text = "$\(model.amount)"
        cell.lblItemInfo.text = "-"
        
        //Get Item Image
        if model.image != "" {
            let strItemImage = model.image.replacingOccurrences(of: "~", with: "").replacingOccurrences(of: "\\", with: "/")
            let strImage = "http://fnb-admin.azurewebsites.net" + strItemImage
            let imageURL = URL(string: strImage)
            cell.imageViewItem.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "FoodPlaceHolder"))
        }else {
            cell.imageViewItem.image = UIImage(named: "FoodPlaceHolder")
        }
        
        
        //Veg or Non-Veg
        /*
        if model.IsVeg == 1 {
            //Veg
            cell.imageViewVeg.image = UIImage(named: "Veg")
        }else {
            cell.imageViewVeg.image = UIImage(named: "NonVeg")
        }*/
        
        if arrayCartItem.contains(model.id) {
            //Show few controlls
            cell.btnPlus.isHidden = false
            cell.btnMinus.isHidden = false
            cell.lblNumberOfItem.isHidden = false
            
            //Set Number of Items
            cell.lblNumberOfItem.text = "\(model.numberOfItem)"
            
            //Hide Add Button
            cell.btnAdd.isHidden = true
            
            //UIbutton Action
            cell.btnPlus.tag = indexPath.row
            cell.btnPlus.addTarget(self, action: #selector(btnPlusItemClicked), for: .touchUpInside)
            
            cell.btnMinus.tag = indexPath.row
            cell.btnMinus.addTarget(self, action: #selector(btnMinusItemClicked), for: .touchUpInside)
            
        }else {
            //Hide few controlls
            cell.btnPlus.isHidden = true
            cell.btnMinus.isHidden = true
            cell.lblNumberOfItem.isHidden = true
            
            //Show Add Button
            cell.btnAdd.isHidden = false
        }
        
        
        //UIbutton Action
        cell.btnAdd.tag = indexPath.row
        cell.btnAdd.addTarget(self, action: #selector(btnAddItemClicked), for: .touchUpInside)
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Temporary move to Checkout
        /*let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.MY_CART) as! MyCart
        self.navigationController?.pushViewController(viewCTR, animated: true)*/
    }
}


//MARK: - Web Services
extension Search {
    //MARK: - Get All Categories
    func searchItem(_ strSearch: String) -> Void {
        
        SearchItem.searchItem(strKitchenID: "\(AppUtils.APPDELEGATE().CartDeliveryModel.kitchenId)", strSearch: strSearch, showLoader: true) { (isSuccess, response, error) in
           
            //As it is searching on string, need to remove all objects before assigning new
            self.arrayItems.removeAll()
            
            if error == nil {
                //Get Data
                self.arrayItems = response?.formattedData as! [SearchItem]
                print("Item Count = \(self.arrayItems.count)")
                
                //If any ITEM added to CART, then assign NUMBER OF ITEM to related MODEL
                if AppUtils.APPDELEGATE().arrayCart.count > 0 {
                    for item in AppUtils.APPDELEGATE().arrayCart {
                        for model in self.arrayItems {
                            if model.id == item.itemID {
                                model.numberOfItem = item.numberOfItem!
                            }
                        }
                    }
                }
            }else {
            }
            
            //Reload Table View
            self.tableViewItems.reloadData()
        }
    }
    
    //MARK: - Remove Item from Cart
    func removeItemFromCart(_ itemID: Int) -> Void {
        
        CartModel.deleteItemCart(itemID: itemID, showLoader: true) { (isSuccess, response, error) in
            if isSuccess == true {
                //Success, there is no data getting in response
            }else {
            }
        }
    }
}
