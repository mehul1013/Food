//
//  Introduction.swift
//  OrderFood
//
//  Created by MehulS on 21/07/18.
//  Copyright © 2018 MeHuLa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI

class Introduction: UIViewController {

    internal var IMAGE      : String = "image"
    internal var TITLE      : String = "title"
    internal var SUBTITLE   : String = "subtitle"
    
    @IBOutlet weak var collectionViewIntro: UICollectionView!
    @IBOutlet weak var btnMobileNumber: UIButton!
    @IBOutlet weak var pageControler: UIPageControl!
    
    @IBOutlet weak var Constraint_Vertical_Space_MobileNumber: NSLayoutConstraint!
    
    var arrayIntro = [[String : String]]()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        arrayIntro = [[IMAGE : "intro1", TITLE : "Hello Food!", SUBTITLE : "Order from a wide range of restaurants"],
                      [IMAGE : "intro2", TITLE : "Cuisines", SUBTITLE : "with a wide collections of cuisines"],
                      [IMAGE : "intro3", TITLE : "Delivery", SUBTITLE : "delivered quickly to your doorstep"]]
        
        //Check device is iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.Constraint_Vertical_Space_MobileNumber.constant = 15
        }
        
        
        //Check if user have already TOKEN
        //Get Authorise Token if app have
        if let token = UserDefaults.standard.value(forKey: "token") as? String {
            //Navigate to next screen
            self.navigateToLandingPage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Enter Mobile Number
    @IBAction func btnEnterMobileNumberClicked(_ sender: Any) {
        //Not Available, get it
        let auth = FUIAuth.defaultAuthUI()
        auth?.delegate = self
        let phoneAuth = FUIPhoneAuth(authUI: auth!)
        auth?.providers = [phoneAuth]
        phoneAuth.signIn(withPresenting: self, phoneNumber: "")
    }
    
    
    //MARK: - Navigate to Landing Page
    func navigateToLandingPage() -> Void {
        let viewCTR = Constants.StoryBoardFile.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.LANDING_PAGE) as! LandingPage
        self.navigationController?.pushViewController(viewCTR, animated: true)
    }
}


//MARK: - UICollectionView Methods
extension Introduction : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.frame.size.height + 20)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayIntro.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //CellIntro
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIntro", for: indexPath) as! CellIntro
        
        let model = self.arrayIntro[indexPath.row]
        
        //Set Data
        cell.imageViewIntro.image = UIImage(named: model[IMAGE]!)
        cell.lblTitle.text = model[TITLE]
        cell.lblSubTitle.text = model[SUBTITLE]
        
        //Check device is iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            cell.constraint_Top_lblTitle.constant = 30
            cell.constraint_Top_lblSubTitle.constant = 15
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        let page = (scrollView.contentOffset.x + (0.5 * width)) / width
        self.pageControler.currentPage = Int(page)
    }
}


//MARK: - Firebase Delegates
extension Introduction: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error == nil {
            //Success
            //print("Result : \(authDataResult?.additionalUserInfo?.providerID)") //Phone
            //print("Result : \(authDataResult?.additionalUserInfo?.isNewUser)") //False
            //print("Result : \(authDataResult?.user.phoneNumber)")
            //print("Result : \(authDataResult?.user.uid)")
            //print("Result : \(authDataResult?.user.providerID)") //Firebase
            
            //Get Mobile Number
            if let phoneNumber = authDataResult?.user.phoneNumber {
                UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                UserDefaults.standard.synchronize()
                
                //Register Customer
                self.registerCustomer(phoneNumber)
            }
            
        }else {
            //Fail
            print("Error : \(error?.localizedDescription)")
            
            //If it is Simulator
            if UIDevice.isSimulator {
                self.navigateToLandingPage()
            }
        }
    }
}

//MARK: - Web Services
extension Introduction {
    //MARK: - Register Customer
    func registerCustomer(_ mobileNumber: String) -> Void {
        UserModel.registerUser(mobileNumber: mobileNumber, showLoader: true) { (isSuccess, response, error) in
            if isSuccess == true {
                //Get Data
                if let token = response?.data as? String {
                    print("Authorise Token : \(token)")
                    
                    //Temp GUID stored
                    UserDefaults.standard.set(token, forKey: "token")
                    UserDefaults.standard.synchronize()
                    
                    //Store GUID
                    AppUtils.APPDELEGATE().token = token
                    
                    //Navigate To Landing Page
                    DispatchQueue.main.async {
                        self.navigateToLandingPage()
                    }
                    
                }
            }else {
            }
        }
    }
}
