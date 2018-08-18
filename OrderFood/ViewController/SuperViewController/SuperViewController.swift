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
    
    var lblNoData: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Create No Data Label
        lblNoData = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height - 50))
        lblNoData.backgroundColor = UIColor.white
        lblNoData.textColor = Colors.MAROON
        lblNoData.textAlignment = .center
        lblNoData.font = UIFont(name: Constants.Fonts.Roboto_Medium, size: 17.0)
        lblNoData.text = "No Data found."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showNoData(_ viewCTR: UIViewController) -> Void {
        viewCTR.view.addSubview(lblNoData)
        viewCTR.view.bringSubview(toFront: lblNoData)
        
        //Show No Data
        lblNoData.isHidden = false
    }
    
    func hideNoData() -> Void {
        lblNoData.isHidden = true
        lblNoData.removeFromSuperview()
    }
    
    
    //MARK: - Back Button
    @IBAction func backButtonClicked() -> Void {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
