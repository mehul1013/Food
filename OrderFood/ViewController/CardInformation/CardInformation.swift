//
//  CardInformation.swift
//  OrderFood
//
//  Created by MehulS on 09/06/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import CCValidator
import AuthorizeNetAccept

class CardInformation: SuperViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var btnSaveCard: UIButton!
    @IBOutlet weak var imageViewCardType: UIImageView!
    
    //Declare object of Authorised.Net
    var handler: AcceptSDKHandler!
    var request: AcceptSDKRequest!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Credit Card"
        
        //Padding View
        let viewPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: txtName.frame.size.height))
        viewPadding.backgroundColor = UIColor.clear
        
        //Layer Properties
        txtName.layer.cornerRadius = 5.0
        txtName.layer.borderColor = UIColor.lightGray.cgColor
        txtName.layer.borderWidth = 1.0
        
        //Add Padding
        //txtName.leftView = viewPadding
        //txtName.leftViewMode = .always
        
        txtCardNumber.layer.cornerRadius = 5.0
        txtCardNumber.layer.borderColor = UIColor.lightGray.cgColor
        txtCardNumber.layer.borderWidth = 1.0
        
        //Add Padding
        //txtCardNumber.leftView = viewPadding
        //txtCardNumber.leftViewMode = .always
        
        txtMonth.layer.cornerRadius = 5.0
        txtMonth.layer.borderColor = UIColor.lightGray.cgColor
        txtMonth.layer.borderWidth = 1.0
        
        txtYear.layer.cornerRadius = 5.0
        txtYear.layer.borderColor = UIColor.lightGray.cgColor
        txtYear.layer.borderWidth = 1.0
        
        txtCVV.layer.cornerRadius = 5.0
        txtCVV.layer.borderColor = UIColor.lightGray.cgColor
        txtCVV.layer.borderWidth = 1.0
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.initialiseAuthorise(_:)), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initialiseAuthorise(_ timer: Any) -> Void {
        //Initialise Handler and Request object
        handler = AcceptSDKHandler(environment: AcceptSDKEnvironment.ENV_TEST)
        
        request = AcceptSDKRequest()
        request.merchantAuthentication.name = Constants.kClientName_AUTHORISE_SANDBOX
        request.merchantAuthentication.clientKey = Constants.kClientKey_AUTHORISE_SANDBOX
    }
    
    //MARK: - UIButton Actions
    @IBAction func btnSaveCardClicked(_ sender: Any) {
        if self.btnSaveCard.isSelected == false {
            self.btnSaveCard.isSelected = true
        }else {
            self.btnSaveCard.isSelected = false
        }
    }
    
    @IBAction func btnAddCardClicked(_ sender: Any) {
        //Validations
        if (txtName.text?.count)! <= 0 {
            AppUtils.showAlertWithTitle(title: "", message: "Please input Name on Card.", viewController: self)
        }else if (txtCardNumber.text?.count)! <= 0 {
            AppUtils.showAlertWithTitle(title: "", message: "Please input Card number.", viewController: self)
        }else if (txtMonth.text?.count)! <= 0 {
            AppUtils.showAlertWithTitle(title: "", message: "Please input expiration month expiration of card.", viewController: self)
        }else if (txtYear.text?.count)! <= 0 {
            AppUtils.showAlertWithTitle(title: "", message: "Please input expiration year expiration of card.", viewController: self)
        }else if (txtCVV.text?.count)! <= 0 {
            AppUtils.showAlertWithTitle(title: "", message: "Please input CVV number behind of card.", viewController: self)
        }else {
            //Proceed to Payment
            self.proceedToAuthorisePayment()
        }
    }
    
    
    //MARK: - Navigate To Order Confirmation
    func navigateToOrderConfirmation() -> Void {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.ORDER_CONFIRMATION) as! OrderConfirmation
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}

//MARK: - Authorise Payment
extension CardInformation {
    func proceedToAuthorisePayment() -> Void {
        //Start Loading
        AppUtils.startLoading(view: self.view)
        
        request.securePaymentContainerRequest.webCheckOutDataType.token.cardNumber = self.txtCardNumber.text!
        request.securePaymentContainerRequest.webCheckOutDataType.token.expirationMonth = self.txtMonth.text!
        request.securePaymentContainerRequest.webCheckOutDataType.token.expirationYear = self.txtYear.text!
        request.securePaymentContainerRequest.webCheckOutDataType.token.cardCode = self.txtCVV.text!
        
        handler!.getTokenWithRequest(request, successHandler: { (inResponse:AcceptSDKTokenResponse) -> () in
            
            //Success
            DispatchQueue.main.async {
                //Stop Loading
                AppUtils.stopLoading()
                
                //Update UI, if needed
                
                print("Token--->%@", inResponse.getOpaqueData().getDataValue())
                
                var output = String(format: "Response: %@\nData Value: %@ \nDescription: %@", inResponse.getMessages().getResultCode(), inResponse.getOpaqueData().getDataValue(), inResponse.getOpaqueData().getDataDescriptor())
                output = output + String(format: "\nMessage Code: %@\nMessage Text: %@", inResponse.getMessages().getMessages()[0].getCode(), inResponse.getMessages().getMessages()[0].getText())
                
                print("Success Output : \(output)")
                
                let alertController = UIAlertController(title: "SUCCESS", message: output, preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
                    //Navigate To Order Confirmation
                    self.navigateToOrderConfirmation()
                }
                
                alertController.addAction(okAction)
                
                self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                
            }
        }) { (inError:AcceptSDKErrorResponse) -> () in
            //Stop Loading
            AppUtils.stopLoading()
            
            //Update UI, If needed
            
            let output = String(format: "Response:  %@\nError code: %@\nError text:   %@", inError.getMessages().getResultCode(), inError.getMessages().getMessages()[0].getCode(), inError.getMessages().getMessages()[0].getText())
            
            print("Failure Output : \(output)")
        }
    }
}


//MARK: - UITextField Methods
extension CardInformation: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 11 {
            //Highlight Card Number
            txtCardNumber.becomeFirstResponder()
        }else if textField.tag == 12 {
            //Highlight Month
            txtMonth.becomeFirstResponder()
        }else if textField.tag == 13 {
            //Highlight Year
            txtYear.becomeFirstResponder()
        }else if textField.tag == 14 {
            //Highlight CVV
            txtCVV.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            print(updatedText)
            
            let recognizedType = CCValidator.typeCheckingPrefixOnly(creditCardNumber: updatedText)
            print(recognizedType.rawValue)
            //check if type is e.g. .Visa, .MasterCard or .NotRecognized
            
            switch(recognizedType) {
            case .Visa:
                self.imageViewCardType.image = UIImage(named: CardType.Visa)
                break
                
            case .MasterCard:
                self.imageViewCardType.image = UIImage(named: CardType.MasterCard)
                break
                
            default:
                self.imageViewCardType.image = UIImage(named: CardType.Unknown)
                break
            }
        }
        return true
    }
}
