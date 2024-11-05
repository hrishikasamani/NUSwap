//
//  ViewController.swift
//  NUSwap
//
//  Created by Dhruv Doshi on 10/24/24.
//

import UIKit

class ViewController: UIViewController {

    //MARK: initializing the First Screen View...
    let loginScreen = LoginView()
    
    let defaults = UserDefaults.standard
    
    //MARK: add the view to this controller while the view is loading...
    override func loadView() {
        
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title="Login"
        
        loginScreen.buttonLogin.addTarget(self, action: #selector(onButtonClickLoginTapped), for: .touchUpInside)
        
        loginScreen.buttonRegister.addTarget(self, action: #selector(onButtonClickRegisterTapped), for: .touchUpInside)
        
        loginScreen.buttonJumpToItemDesc.addTarget(self, action: #selector(onButtonJumpToItemDescTapped), for: .touchUpInside)
        
        loginScreen.addListing.addTarget(self, action: #selector(onButtonAddListingTapped), for: .touchUpInside)
        
    }
    @objc func onButtonAddListingTapped(){
        
        let newListingViewController = NewListingViewController()
        navigationController?.pushViewController(newListingViewController, animated: true)
    }
    
    @objc func onButtonClickLoginTapped(){
        
        // collect entered information
//        if let email = loginScreen.textFieldEmail.text,
//           let password = loginScreen.textFieldPassword.text {
//            loginUserAPI(email: email, password: password)
//        }
        
        let displayProfileViewController = DisplayProfileViewController()
        
        navigationController?.pushViewController(displayProfileViewController, animated: true)
        
    }

    @objc func onButtonClickRegisterTapped() {
        // Instantiate the RegisterViewController
        let registerViewController = RegisterViewController()
        
        // Replace the current view stack to remove the LoginView
        navigationController?.setViewControllers([registerViewController], animated: true)
    }
    
    func loginUserAPI(email: String, password: String){
        
    }
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    @objc func onButtonJumpToItemDescTapped() {
        let itemDescVC = ItemDescriptionViewController()
        self.navigationController?.pushViewController(itemDescVC, animated: true)
    }


}

