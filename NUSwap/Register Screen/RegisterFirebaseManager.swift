//
//  RegisterFirebaseManager.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount() {
        showActivityIndicator()
        
        guard let name = registerScreen.textFieldName.text,
              let email = registerScreen.textFieldEmail.text?.lowercased(),
              let phone = registerScreen.textFieldPhone.text,
              let password = registerScreen.textFieldPassword.text else {
            hideActivityIndicator()
            showErrorAlert(message: "Please fill all fields.")
            return
        }
        
        // check if the email is already registered in Firestore
        let database = Firestore.firestore()
        database.collection("users").document(email).getDocument { documentSnapshot, error in
            if let error = error {
                self.hideActivityIndicator()
                print("Error checking user existence: \(error.localizedDescription)")
                self.showErrorAlert(message: "An error occurred. Please try again.")
                return
            }
            
            if let document = documentSnapshot, document.exists {
                // email already registered
                self.hideActivityIndicator()
                self.showErrorAlert(message: "This email is already registered. Please use a different email or log in.")
            } else {
                // proceed with registration
                self.createFirebaseUser(name: name, email: email, phone: phone, password: password)
            }
        }
    }
    
    // helper method to create firebase user
    func createFirebaseUser(name: String, email: String, phone: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.hideActivityIndicator()
                print("Error creating user: \(error.localizedDescription)")
                self.showErrorAlert(message: "Registration failed. Please try again.")
                return
            }
            
            // user created
            self.setNameOfTheUserInFirebaseAuth(name: name, email: email, phone: phone)
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String, email: String, phone: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.hideActivityIndicator()
                // Take user to chats screen instead of print
                print("User reistered successfully")
                self.saveUserToFirestore(name: name, email: email, phone: phone)
                self.navigateToHomePage()
            }else{
                //MARK: there was an error updating the profile...
                self.hideActivityIndicator()
                print("Error occured: \(String(describing: error))")
                self.showErrorAlert(message: "Registration failed. Try again.")
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
            
            navigationController?.setViewControllers([homePage], animated: true)
    }
    
    func saveUserToFirestore(name: String, email: String, phone: String) {
        let database = Firestore.firestore()
        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone
        ]
        database.collection("users").document(email).setData(userData) { error in
            self.hideActivityIndicator()
            if let error = error {
                print(email)
                print("error saving user to firestore: \(error.localizedDescription)")
                self.showErrorAlert(message: "Failed to save user")
            } else {
                print("user registered and saved to firestore.")
                self.navigateToHomePage()
            }
        }
    }
}
