//
//  CardInformation.swift
//  OrderFood
//
//  Created by MehulS on 09/06/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import CCValidator

class CardInformation: SuperViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var btnSaveCard: UIButton!
    @IBOutlet weak var imageViewCardType: UIImageView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Credit Card"
        
        //Layer Properties
        txtName.layer.cornerRadius = 5.0
        txtName.layer.borderColor = UIColor.lightGray.cgColor
        txtName.layer.borderWidth = 1.0
        
        txtCardNumber.layer.cornerRadius = 5.0
        txtCardNumber.layer.borderColor = UIColor.lightGray.cgColor
        txtCardNumber.layer.borderWidth = 1.0
        
        txtMonth.layer.cornerRadius = 5.0
        txtMonth.layer.borderColor = UIColor.lightGray.cgColor
        txtMonth.layer.borderWidth = 1.0
        
        txtYear.layer.cornerRadius = 5.0
        txtYear.layer.borderColor = UIColor.lightGray.cgColor
        txtYear.layer.borderWidth = 1.0
        
        txtCVV.layer.cornerRadius = 5.0
        txtCVV.layer.borderColor = UIColor.lightGray.cgColor
        txtCVV.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
