//
//  DisplayProfileViewController.swift
//  WA4_Doshi_6855
//
//  Created by Dhruv Doshi on 10/3/24.
//

import UIKit

class DisplayProfileViewController: UIViewController {

    //MARK: creating instance of DisplayView...
    let displayProfileScreen = DisplayProfileView()
    
    
    
    //MARK: patch the view of the controller to the DisplayView...
    override func loadView() {
        view = displayProfileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Profile"
        
        
//        getProfileDetailsAPI(currentUser: self.currentUser)
       
    }
    
//    func getProfileDetailsAPI(currentUser: User){
//
//    }
    
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
}
