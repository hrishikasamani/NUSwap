//
//  LoginFirebaseManager.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/23/24.
//

import Foundation
import FirebaseAuth
import UIKit

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
        // Fetch listings immediately after navigating to the home page
            if let homeNavController = homePage.viewControllers?.first as? UINavigationController,
               let homeVC = homeNavController.viewControllers.first as? HomePageViewController {
                homeVC.fetchListings()
            }

        

        

        // Find a UIWindowScene in the foreground state
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }) {
            
            if let window = windowScene.windows.first {
                window.rootViewController = homePage
                window.makeKeyAndVisible()
            }
        }
        
        
    }
}
