//
//  RegisterViewController.swift
//  App10
//
//  Created by Dhruv Doshi on 10/27/24.
//

import UIKit

class RegisterViewController: UIViewController {

    //MARK: initializing the First Screen View...
    let registerScreen = RegisterView()
    
    let defaults = UserDefaults.standard
    
    //MARK: add the view to this controller while the view is loading...
    override func loadView() {
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        //title = "Register"
        
        registerScreen.buttonLogin.addTarget(self, action: #selector(onButtonClickLoginTapped), for: .touchUpInside)
        
        registerScreen.buttonRegister.addTarget(self, action: #selector(onButtonClickRegisterTapped), for: .touchUpInside)
        
        registerScreen.textFieldPhone.keyboardType = .numberPad // Ensure the phone number uses number pad
    }
    
    @objc func onButtonClickLoginTapped() {
        // Instantiate the LoginViewController
        let loginViewController = ViewController()
        
        // Replace the current view stack to remove the RegisterView
        navigationController?.setViewControllers([loginViewController], animated: true)
    }

    @objc func onButtonClickRegisterTapped() {
        guard let name = registerScreen.textFieldName.text,
              let email = registerScreen.textFieldEmail.text,
              let phone = registerScreen.textFieldPhone.text,
              let password = registerScreen.textFieldPassword.text,
              let verifyPassword = registerScreen.textFieldVerifyPassword.text else {
            showErrorAlert(message: "Please fill all fields.")
            return
        }
        
        // Validate email
        if !isValidEmail(email) {
            showErrorAlert(message: "Please use a valid Northeastern email (xyz@northeastern.edu).")
            return
        }
        
        // Validate phone number
        if phone.count != 10 || Int(phone) == nil {
            showErrorAlert(message: "Please enter a valid 10-digit phone number.")
            return
        }
        
        // Validate password matching
        if password != verifyPassword {
            showErrorAlert(message: "Passwords do not match.")
            return
        }
        
        // Register success: Navigate to Home Page
        let homeVC = MainTabBarController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@northeastern\\.edu"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
