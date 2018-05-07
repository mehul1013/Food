//
//  AppUtils.swift
//  WhiteLeafBooks
//
//  Created by MehulS on 10/07/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit

class AppUtils: NSObject {
    //MARK: App Delegate Object
    static func APPDELEGATE() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK: Validations For Email
    static func validateEmail(strEmail : String)-> Bool {
        let emailRegex : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: strEmail)
    }
    
    
    //MARK: - Show Alert
    static func showAlertWithTitle(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title as String , message: message, preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        // Add the actions
        alert.addAction(actionCancel)
        
        //viewController.present(alert, animated: true, completion: nil)
        viewController.view.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
