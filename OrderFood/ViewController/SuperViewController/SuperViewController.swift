//
//  SuperViewController.swift
//  StrongFriends
//
//  Created by Mehul Solanki on 01/01/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

//Extension
//UITextField
/*
extension UITextField: UITextFieldDelegate {
    //Placeholder Color
    @IBInspectable var placeholderColor: UIColor? {
        get{
            return self.placeholderColor
        }
        set{
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey : newValue!])
        }
    }
}*/

class SuperViewController: UIViewController {
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Back Button
    @IBAction func backButtonClicked() -> Void {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
