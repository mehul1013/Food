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
    
}


class OrderInformation: SuperViewController {

    @IBOutlet weak var tableViewOrderInfo: UITableView!
    
    var arraySection0Title = ["Order Number", "Payment", "Date", "Deliver To"]
    var arraySection0SubTitle = ["9ewf4ewfew4ewf654e6ew1f694fwe1ef1w", "Cash", "Jan 26, 2016 at 2:40 PM", "A - 1"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Order Summary"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//MARK: - UITableView Methods
extension OrderInformation: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 65
        }else {
            return 40
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
            cell = tableView.dequeueReusableCell(withIdentifier: "CellMyCartItem") as! CellOrderInfo
            
            cell.lblItemName.text = "Cheese Pizza x 1"
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
