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
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Category \(index)"
        
        //Add TableView
        tableViewItems = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - (60 + 40)))
        view.addSubview(tableViewItems)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableView Delegates
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CellTemp
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTemp") as! CellItem
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Temporary move to Checkout
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.MY_CART) as! MyCart
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}
