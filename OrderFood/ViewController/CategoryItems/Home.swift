//
//  ViewController.swift
//  OrderFood
//
//  Created by MehulS on 04/05/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import Parchment

class Home: SuperViewController {

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Navigation Title
        self.navigationItem.title = "Home"
        
        //Right Bar Button
        let rightBar = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchClicked))
        self.navigationItem.rightBarButtonItem = rightBar
        
        //Category wise controller
        let viewControllers = (0...10).map { CategoryViewController(index: $0) }
        
        /*var arrayViewCTR = [CategoryViewController]()
        for index in 0...10 {
            let viewCTR = CategoryViewController(index: index)
            arrayViewCTR.append(viewCTR)
        }*/
        
        let pagingViewController = FixedPagingViewController(viewControllers: viewControllers)
                
        // Make sure you add the PagingViewController as a child view
        // controller and constrain it to the edges of the view.
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - Search
    func searchClicked() -> Void {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.SEARCH) as! Search
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}

