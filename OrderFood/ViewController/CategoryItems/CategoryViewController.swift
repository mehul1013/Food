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
    var arraySelectedRow = [Int]()
    var arrayItems = [Item]()
    
    var indexOfCategory: Int = 0
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        
        //Get Index
        self.indexOfCategory = index
        
        //self.title = "Category \(index)"
        
        let model = AppUtils.APPDELEGATE().arrayCategory[index]
        self.title = model.CategoryName
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Reload TableView
        self.tableViewItems.delegate = self
        self.tableViewItems.dataSource = self
        
        self.tableViewItems.estimatedRowHeight = 130
        self.tableViewItems.rowHeight = UITableViewAutomaticDimension
        
        self.tableViewItems.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.arrayItems.count <= 0 {
            //Call Web Service
            self.getItemForCategory(self.indexOfCategory)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Add Item
    func btnAddItemClicked(_ sender: UIButton) -> Void {
        //Get Cell
        if let cell = self.tableViewItems.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? CellItem {
            
            //Add item to Cart
            if let numberOfItem = Int(cell.lblNumberOfItem.text!) {
                //Get Model
                
                //Add New Cart
                let cart = Cart()
                cart.itemID = "1"
                cart.itemName = "Share An Appetizer"
                cart.numberOfItem = 1
                cart.price = 50.0
                
                AppUtils.APPDELEGATE().arrayCart.append(cart)
            }
            
            //Check if need to show Cart View
            if AppUtils.APPDELEGATE().arrayCart.count <= 0 {
                //Post Observer
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ManageCartView"), object: nil)
            }
            
            //Update Flag
            self.arraySelectedRow.append(sender.tag)
            
            //Reload Cell
            self.tableViewItems.reloadData()
        }
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
            cell.imageViewItem.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "FoodItem.png"))
        }else {
            cell.imageViewItem.image = UIImage(named: "FoodItem.png")
        }
        
        
        //Veg or Non-Veg
        if model.IsVeg == 1 {
            //Veg
            cell.imageViewVeg.image = UIImage(named: "Veg")
        }else {
            cell.imageViewVeg.image = UIImage(named: "NonVeg")
        }
        
        if arraySelectedRow.contains(indexPath.row) {
            //Show few controlls
            cell.btnPlus.isHidden = false
            cell.btnMinus.isHidden = false
            cell.lblNumberOfItem.isHidden = false
            
            //Hide Add Button
            cell.btnAdd.isHidden = true
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
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.MY_CART) as! MyCart
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}


//MARK: - Web Services
extension CategoryViewController {
    //MARK: - Get All Categories
    func getItemForCategory(_ index: Int) -> Void {
        
        let model = AppUtils.APPDELEGATE().arrayCategory[index]
        
        Item.getItemForCategory(strCategoryID: "\(model.CategoryId)", showLoader: true) { (isSuccess, response, error) in
            
            if error == nil {
                //Get Data
                self.arrayItems = response?.formattedData as! [Item]
                print("Item Count = \(self.arrayItems.count)")
                
                if self.arrayItems.count > 0 {
                    //Reload Table View
                    self.tableViewItems.reloadData()
                }
            }else {
            }
        }
    }
}
