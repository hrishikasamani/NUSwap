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
        
        title="Register"
        
        registerScreen.buttonLogin.addTarget(self, action: #selector(onButtonClickLoginTapped), for: .touchUpInside)
        
        registerScreen.buttonRegister.addTarget(self, action: #selector(onButtonClickRegisterTapped), for: .touchUpInside)
    }
    
    @objc func onButtonClickLoginTapped(){
        // Instantiate the RegisterViewController
        let loginViewController = ViewController()
        
        // Replace the current view stack to remove the LoginView
        navigationController?.setViewControllers([loginViewController], animated: true)
    }

    @objc func onButtonClickRegisterTapped() {
        

    }
    
    func registerUserAPI(name: String, email: String, password: String){
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }

}
