//
//  OrderConfirmation.swift
//  OrderFood
//
//  Created by MehulS on 21/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class OrderConfirmation: SuperViewController {

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "Order Confirmation"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//MARK: - UICollectionView Methods
extension OrderConfirmation: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.size.width - 75) / 4
        
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 {
            return CGSize(width: width, height: collectionView.frame.size.height)
        }else {
            return CGSize(width: 25, height: collectionView.frame.size.height)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: CellOrder!
        
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellOrderStatus", for: indexPath) as! CellOrder
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForwardArrow", for: indexPath) as! CellOrder
        }
        
        return cell
    }
}
