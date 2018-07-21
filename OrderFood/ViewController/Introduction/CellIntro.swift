//
//  CellIntro.swift
//  OrderFood
//
//  Created by MehulS on 21/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class CellIntro: UICollectionViewCell {
    
    @IBOutlet weak var imageViewIntro: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var constraint_Top_lblTitle: NSLayoutConstraint!
    @IBOutlet weak var constraint_Top_lblSubTitle: NSLayoutConstraint!
}
