//
//  OrderInformation.swift
//  OrderFood
//
//  Created by MehulS on 15/08/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit


class CellOrderInfo: UITableViewCell {
    //CellHeader
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    //CellOrderInfo
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    //CellMyCartItem
    @IBOutlet weak var imageViewVegOrNot: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    
}


class OrderInformation: SuperViewController {

    @IBOutlet weak var tableViewOrderInfo: UITableView!
    
    var strOrderID: String = ""
    var orderInfo: MyOrderInfo!
    var arrayItem = [MyOrderItemInfo]()
    
    var arraySection0Title = ["Order Number", "Payment", "Date", "Deliver To"]
    var arraySection0SubTitle = ["", "", "", ""]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Order Summary"
        
        //Get Order Information
        self.getOrderInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Set Data
    func setData() -> Void {
        arraySection0SubTitle[0] = self.strOrderID
        arraySection0SubTitle[1] = "Cash"
        arraySection0SubTitle[2] = self.orderInfo.orderDesc.orderDate
        arraySection0SubTitle[3] = "\(self.orderInfo.orderDesc.rowName) - \(self.orderInfo.orderDesc.seatName)"
        
        //Get Items
        for item in self.orderInfo.itemArray! {
            self.arrayItem.append(item)
        }
        
        //Reload TableView
        self.tableViewOrderInfo.reloadData()
    }
}


//MARK: - UITableView Methods
extension OrderInformation: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.arraySection0SubTitle.count
        }
        if self.arrayItem.count > 0 {
            return self.arrayItem.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 65
        }else {
            if indexPath.row >= self.arrayItem.count {
                return 115
            }
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "CellHeader") as! CellOrderInfo
        
        if section == 0 {
            cellHeader.lblHeaderTitle.text = "ORDER DETAIL"
        }else {
            cellHeader.lblHeaderTitle.text = "ORDER SUMMARY"
        }
        
        return cellHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CellOrderInfo!
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellOrderInfo") as! CellOrderInfo
            
            cell.lblTitle.text = self.arraySection0Title[indexPath.row]
            cell.lblSubTitle.text = self.arraySection0SubTitle[indexPath.row]
            
        }else {
            if indexPath.row >= self.arrayItem.count {
                let cellTotal = tableView.dequeueReusableCell(withIdentifier: "CellTotal") as! CellMyCart
                
                //Set Data
                cellTotal.lblSubTotal.text   = "$\(self.orderInfo.orderDesc.itemAmount)"
                cellTotal.lblTaxes.text      = "$\(self.orderInfo.orderDesc.tax)"
                cellTotal.lblGrandTotal.text = "$\(self.orderInfo.orderDesc.totalAmount)"
                
                cellTotal.selectionStyle = .none
                return cellTotal
                
            }else {
                cell = tableView.dequeueReusableCell(withIdentifier: "CellMyCartItem") as! CellOrderInfo
                
                //Get Model
                let model = self.arrayItem[indexPath.row]
                
                cell.lblItemName.text = model.name + " x \(model.qty)"
                cell.lblPrice.text = "$ \(model.total)"
                cell.lblOrderStatus.text = model.status
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
}


//MARK: - Web Service
extension OrderInformation {
    //Get Order Information
    func getOrderInformation() -> Void {
        MyOrderInfo.getOrderInfo(strOrderID: self.strOrderID, showLoader: true) { (isSuccess, response, error) in
            if isSuccess == true {
                //Get Data
                self.orderInfo = response?.formattedData as! MyOrderInfo
                print("Order Info = \(self.orderInfo)")
                
                //Set Data
                DispatchQueue.main.async {
                    self.setData()
                }
                
            }else {
            }
        }
    }
}
