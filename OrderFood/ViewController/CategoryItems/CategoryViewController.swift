//
//  CategoryViewController.swift
//  OrderFood
//
//  Created by MehulS on 04/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    var tableViewItems: UITableView!
    var arrayCartItem = [Int]()
    var arrayItems = [Item]()
    
    var indexOfCategory: Int = 0
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        
        //Get Index
        self.indexOfCategory = index
        
        //self.title = "Category \(index)"
        
        let model = AppUtils.APPDELEGATE().arrayCategory[index]
        self.title = model.CategoryName
        
        //Get Items from CART, if any
        self.getItemsFromCart()

        //Add TableView
        tableViewItems = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (60 + 40) - 54))
        view.addSubview(tableViewItems)
        
        //Bottom Padding
        tableViewItems.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
        //Register Cell
        tableViewItems.register(UINib(nibName: "CellItem", bundle: nil), forCellReuseIdentifier: "CellTemp")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Reload TableView
        self.tableViewItems.delegate = self
        self.tableViewItems.dataSource = self
        
        self.tableViewItems.estimatedRowHeight = 130
        self.tableViewItems.rowHeight = UITableViewAutomaticDimension
        
        self.tableViewItems.reloadData()
        
        
        //Add Observer to Show/Hide Cart View
        if AppUtils.APPDELEGATE().isCategoryClassObserverAdded == false {
            //Update Flag
            AppUtils.APPDELEGATE().isCategoryClassObserverAdded = true
            
            NotificationCenter.default.addObserver(self, selector: #selector(CategoryViewController.UpdateModelRegardingCart), name: NSNotification.Name(rawValue: "UpdateModelRegardingCart"), object: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.arrayItems.count <= 0 {
            //Call Web Service
            self.getItemForCategory(self.indexOfCategory, isNeedToShowLoader: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Observer
    func UpdateModelRegardingCart(_ notification: Notification) -> Void {
        //Call Web Service, to get modified value from CART if available
        self.getItemForCategory(self.indexOfCategory, isNeedToShowLoader: true)
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
            cart.itemID = model.FoodItemId
            cart.itemName = model.FoodItemName
            cart.numberOfItem = 1
            cart.price = model.Amount
            
            AppUtils.APPDELEGATE().arrayCart.append(cart)
            
            //Update Selected ItemID
            self.arrayCartItem.append(model.FoodItemId)
            
            //Check if need to show Cart View
            if AppUtils.APPDELEGATE().arrayCart.count > 0 {
                //Post Observer
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ManageCartView"), object: nil)
            }
            
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
            if item.itemID == model.FoodItemId {
                numberOfItems = numberOfItems + 1
                
                //Assign new value to cart
                item.numberOfItem = numberOfItems
                
                //Assign new value to model
                model.numberOfItem = numberOfItems
                
                //Reload UITableView
                self.tableViewItems.reloadData()
            }
        }
        
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
            if item.itemID == model.FoodItemId {
                numberOfItems = numberOfItems - 1
                
                //If it is getting 0 or less, make it 0
                if numberOfItems <= 0 {
                    numberOfItems = 0
                }
                
                //Assign new value to cart
                item.numberOfItem = numberOfItems
                
                //Assign new value to model
                model.numberOfItem = numberOfItems
                
                //if it gets 0, remove from CART
                if numberOfItems <= 0 {
                    let index = AppUtils.APPDELEGATE().arrayCart.index(of: item)
                    AppUtils.APPDELEGATE().arrayCart.remove(at: index!)
                    
                    //Get Items from CART, if any
                    self.getItemsFromCart()
                }
                
                //Reload UITableView
                self.tableViewItems.reloadData()
            }
        }
        
        //Post Observer
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ManageCartView"), object: nil)
    }
}

//MARK: - UITableView Delegates
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
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
        cell.lblName.text = model.FoodItemName
        cell.lblPrice.text = "$\(model.Amount)"
        cell.lblItemInfo.text = model.FoodItemDesc
        
        //Get Item Image
        if model.Image != "" {
            let strItemImage = model.Image.replacingOccurrences(of: "~", with: "").replacingOccurrences(of: "\\", with: "/")
            let strImage = "http://fnb-admin.azurewebsites.net" + strItemImage
            let imageURL = URL(string: strImage)
            cell.imageViewItem.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "FoodPlaceHolder"))
        }else {
            cell.imageViewItem.image = UIImage(named: "FoodPlaceHolder")
        }
        
        
        //Veg or Non-Veg
        if model.IsVeg == 1 {
            //Veg
            cell.imageViewVeg.image = UIImage(named: "Veg")
        }else {
            cell.imageViewVeg.image = UIImage(named: "NonVeg")
        }
        
        if arrayCartItem.contains(model.FoodItemId) {
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
extension CategoryViewController {
    //MARK: - Get All Categories
    func getItemForCategory(_ index: Int, isNeedToShowLoader: Bool) -> Void {
        
        let model = AppUtils.APPDELEGATE().arrayCategory[index]
        
        Item.getItemForCategory(strCategoryID: "\(model.CategoryId)", showLoader: isNeedToShowLoader) { (isSuccess, response, error) in
            
            if error == nil {
                //Remove Data if there is
                self.arrayItems.removeAll()
                
                //Get Data
                self.arrayItems = response?.formattedData as! [Item]
                print("Item Count = \(self.arrayItems.count)")
                
                if self.arrayItems.count > 0 {
                    
                    //If any ITEM added to CART from SEARCH screen, then assign NUMBER OF ITEM to related MODEL
                    if AppUtils.APPDELEGATE().arrayCart.count > 0 {
                        for item in AppUtils.APPDELEGATE().arrayCart {
                            for model in self.arrayItems {
                                if model.FoodItemId == item.itemID {
                                    model.numberOfItem = item.numberOfItem!
                                }
                            }
                        }
                        
                        //Get Selected Item
                        self.getItemsFromCart()
                    }
                    
                    //Reload Table View
                    self.tableViewItems.reloadData()
                }
            }else {
            }
        }
    }
}
