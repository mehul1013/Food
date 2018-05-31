//
//  AppUtils.swift
//  WhiteLeafBooks
//
//  Created by MehulS on 10/07/16.
//  Copyright © 2016 MehulS. All rights reserved.
//

import UIKit
//import MBProgressHUD

class AppUtils: NSObject {
    
    static var progressView : MBProgressHUD?
    
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
    
    
    //MARK: Loading View
    static func startLoading(view : UIView) {
        progressView = MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    static func startLoadingWithText(strText: String, view : UIView) {
        progressView = MBProgressHUD.showAdded(to: view, animated: true)
        progressView?.labelText = strText
    }
    
    
    class func showLoader() {
        let progressHUD = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow, animated: true)
        progressHUD?.color = UIColor.darkGray
        progressHUD?.labelText = "Loading"
    }
    
    class func showLoaderWithText(_ strText: String) {
        if progressView == nil {
            progressView = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow, animated: true)
        }
        progressView?.color = UIColor.darkGray
        progressView?.labelText = strText
        
        /*
         let progressHUD = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow, animated: true)
         progressHUD?.color = UIColor.darkGray
         progressHUD?.labelText = strText
         */
    }
    
    class func hideLoader() {
        MBProgressHUD.hideAllHUDs(for: UIApplication.shared.keyWindow, animated: true)
    }
    
    static func stopLoading() {
        self.progressView!.hide(true)
    }
    
    static func hudWasHidden() {
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
