//
//  Checkout.swift
//  OrderFood
//
//  Created by Mehul Solanki on 08/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import Razorpay

class Checkout: SuperViewController {

    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewMobile: UIView!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    
    var strTotalAmount: Double = 0.00
    
    //RazorPay
    var razorpay: Razorpay!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Checkout"
        
        //Set Total Amount
        self.lblTotalAmount.text = "$\(strTotalAmount)"
        
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
        
        //RazorPay Initialisation
        razorpay = Razorpay.initWithKey(Constants.KEY_ID_RAZORPAY_SANDBOX, andDelegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UIButton Actions
    //MARK: - Online
    @IBAction func btnOnlineClicked(_ sender: Any) {
        /*
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.ORDER_CONFIRMATION) as! OrderConfirmation
        self.navigationController?.pushViewController(viewCTR, animated: true)
         */
        
        //Navigate to get Card Details
        //let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.CARD_INFORMATION) as! CardInformation
        //self.navigationController?.pushViewController(viewCTR, animated: true)
        
        
        self.openActionSheet()
    }
    
    func openActionSheet() {
        // Create the AlertController
        let actionSheetController = UIAlertController(title: "Online Payment", message: "", preferredStyle: .actionSheet)

        // Create and add first option action
        let p1Action = UIAlertAction(title: "Authorise.net", style: .default) { action -> Void in
            self.navigateToCardInformation()
        }
        actionSheetController.addAction(p1Action)
        
        // Create and add second option action
        let p2Action = UIAlertAction(title: "RazorPay", style: .default) { action -> Void in
            self.proceedRazorPayTransaction()
        }
        actionSheetController.addAction(p2Action)
        
        // Create and add the Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            // Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        // Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    //MARK: - Cash
    @IBAction func btnCashClicked(_ sender: Any) {
        //Navigate To Order Confirmation
        self.navigateToOrderConfirmation()
    }
    
    func navigateToOrderConfirmation() -> Void {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.ORDER_CONFIRMATION) as! OrderConfirmation
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
    
    
    //MARK: - Navigate To Card Information
    func navigateToCardInformation() -> Void {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.CARD_INFORMATION) as! CardInformation
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}


//MARK: - UITextField Methods
extension Checkout: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return resignFirstResponder()
    }
}


//MARK: - RazorPay
extension Checkout: RazorpayPaymentCompletionProtocol {
    
    func proceedRazorPayTransaction() -> Void {
        
        //Set Data
        var strImageURL : String = ""
        if AppUtils.APPDELEGATE().CartDeliveryModel.restaurantImage.contains("https") {
            strImageURL = AppUtils.APPDELEGATE().CartDeliveryModel.restaurantImage
        }else {
            strImageURL = "https:" + AppUtils.APPDELEGATE().CartDeliveryModel.restaurantImage
        }
        
        let options: [String:Any] = [
            "amount" : "\(self.strTotalAmount * 100)", //mandatory in paise
            "description": AppUtils.APPDELEGATE().CartDeliveryModel.restaurantName,
            "image": strImageURL,
            "name": AppUtils.APPDELEGATE().CartDeliveryModel.restaurantName,
            "prefill": [
            "contact": "9797979797",
            "email": "foo@bar.com"
            ],
            "theme": [
                "color": "#F37254"
            ]
        ]
        razorpay.open(options)
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        let alertController = UIAlertController(title: "FAILURE", message: str, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        let alertController = UIAlertController(title: "SUCCESS", message: "Payment Id \(payment_id)", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            //Navigate To Order Confirmation
            self.navigateToOrderConfirmation()
        }
        
        alertController.addAction(okAction)
        
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
