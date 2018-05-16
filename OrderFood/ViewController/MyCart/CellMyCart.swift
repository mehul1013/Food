//
//  CellMyCart.swift
//  OrderFood
//
//  Created by Mehul Solanki on 16/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class CellMyCart: UITableViewCell {
    
    //CellMyCartItem
    @IBOutlet weak var imageViewVegNonVeg: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblNumberOfItem: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    //CellTotal
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTaxes: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    
    
    //CellSpecialInstruction
    @IBOutlet weak var textViewSpecialInstruction: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
