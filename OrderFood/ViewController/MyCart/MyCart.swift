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
    
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "My Cart"
        
        //Remove extra lines from UITableView
        self.tableViewMyCart.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableView Methods
extension MyCart: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2+1+1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row <= 1 {
            return 60
        }else {
            return 115
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CellMyCart
            
        if indexPath.row == 0 || indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellMyCartItem") as! CellMyCart
        }else if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellTotal") as! CellMyCart
        }else {
            cell = tableView.dequeueReusableCell(withIdentifier: "CellSpecialInstruction") as! CellMyCart
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
