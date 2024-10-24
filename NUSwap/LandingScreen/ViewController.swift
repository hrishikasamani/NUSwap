//
//  ViewController.swift
//  NUSwap
//
//  Created by Dhruv Doshi on 10/24/24.
//

import UIKit

class ViewController: UIViewController {

    let landingScreen = LoginView()
    
        
    override func loadView() {
        view = landingScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NU Swap"
        
        landingScreen.buttonNavigate.addTarget(self, action: #selector(onButtonClickNavigate), for: .touchUpInside)
        
    }
    
    
    @objc func onButtonClickNavigate(){
            
            //push your new screen here...
//            navigationController?.pushViewController(editProfileViewController, animated: true)
        }
        
}

