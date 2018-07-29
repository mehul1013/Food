//
//  MyOrders.swift
//  OrderFood
//
//  Created by MehulS on 29/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class MyOrders: SuperViewController {

    @IBOutlet weak var btnCurrentOrder: UIButton!
    @IBOutlet weak var btnPastOrder: UIButton!
    @IBOutlet weak var lblSeparator: UILabel!
    @IBOutlet weak var constraintLeading_Separator: NSLayoutConstraint!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Navigation Bar Title
        self.navigationItem.title = "My Orders"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIButton Actions
    @IBAction func btnCurrentOrderClicked(_ sender: Any) {
        //Animate Separator
        self.constraintLeading_Separator.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnPastOrderClicked(_ sender: Any) {
        //Animate Separator
        let value = UIScreen.main.bounds.size.width / 2
        self.constraintLeading_Separator.constant = value
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}


//MARK: - UICollectionView Methods
extension MyOrders: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 280)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMyOrder", for: indexPath) as! CellMyOrder
        
        return cell
    }
}
