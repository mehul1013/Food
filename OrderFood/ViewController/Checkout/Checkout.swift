//
//  Checkout.swift
//  OrderFood
//
//  Created by Mehul Solanki on 08/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class Checkout: SuperViewController {

    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewMobile: UIView!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Checkout"
        
        //Layer Properties
        viewName.layer.cornerRadius = 5.0
        viewName.layer.borderColor = UIColor.lightGray.cgColor
        viewName.layer.borderWidth = 1.0
        
        viewEmail.layer.cornerRadius = 5.0
        viewEmail.layer.borderColor = UIColor.lightGray.cgColor
        viewEmail.layer.borderWidth = 1.0
        
        viewMobile.layer.cornerRadius = 5.0
        viewMobile.layer.borderColor = UIColor.lightGray.cgColor
        viewMobile.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UIButton Actions
    //MARK: - Online
    @IBAction func btnOnlineClicked(_ sender: Any) {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.ORDER_CONFIRMATION) as! OrderConfirmation
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
    
    //MARK: - Cash
    @IBAction func btnCashClicked(_ sender: Any) {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.ORDER_CONFIRMATION) as! OrderConfirmation
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
    
}


//MARK: - UITextField Methods
extension Checkout: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return resignFirstResponder()
    }
}
