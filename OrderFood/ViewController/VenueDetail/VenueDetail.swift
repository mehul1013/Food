//
//  VenueDetail.swift
//  OrderFood
//
//  Created by MehulS on 05/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit

class VenueDetail: SuperViewController {
    
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Show Navigation Bar
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - View Online Menu
    @IBAction func btnViewMenuClicked(_ sender: Any) {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.HOME) as! Home
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}
