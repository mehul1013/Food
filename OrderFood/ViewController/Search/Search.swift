//
//  Search.swift
//  OrderFood
//
//  Created by MehulS on 17/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class Search: SuperViewController {

    @IBOutlet weak var txtSearch: UITextField!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Search"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//MARK: - UITextField Methods
extension Search: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return resignFirstResponder()
    }
}
