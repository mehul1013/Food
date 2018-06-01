//
//  CellItem.swift
//  OrderFood
//
//  Created by MehulS on 04/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class CellItem: UITableViewCell {

    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var imageViewVeg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCustomizationAvailable: UILabel!
    @IBOutlet weak var lblItemInfo: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblNumberOfItem: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if btnAdd != nil {
            btnAdd.layer.cornerRadius = 5.0
            btnAdd.layer.masksToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
