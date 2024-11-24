//
//  LoginFirebaseManager.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/23/24.
//

import Foundation
import FirebaseAuth

extension ViewController{
    
    func signInToFirebase(email: String, password: String){
        showActivityIndicator()
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...
                self.navigateToHomePage()
                self.hideActivityIndicator()
            } else{
                //MARK: alert that no user found or password wrong...
                self.hideActivityIndicator()
                self.showErrorAlert(message: "Invalid email or password")
            }
        })
    }
    
    func navigateToHomePage() {
        let homePage = MainTabBarController()
        print("User logged in successfully")
        navigationController?.setViewControllers([homePage], animated: true)
        
    }
}
