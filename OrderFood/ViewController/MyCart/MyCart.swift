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
    
    let count = AppUtils.APPDELEGATE().arrayCart.count
    var total = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "My Cart"
        
        //Remove extra lines from UITableView
        self.tableViewMyCart.tableFooterView = UIView(frame: CGRect.zero)
        
        //Get Total and Sub-totle
        for item in AppUtils.APPDELEGATE().arrayCart {
            total = total + (item.numberOfItem! * item.price!)
        }
        
        //Checkout Button
        self.btnCheckout.setTitle("Checkout ($\(total).0)", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Checkout
    @IBAction func btnCheckoutClicked(_ sender: Any) {
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
            cell.lblPrice.text = "$\(model.numberOfItem! * model.price!)"
            
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
