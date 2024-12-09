//
//  ProfileFirebaseManager.swift
//  NUSwap
//
//  Created by Karyn T on 11/26/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

extension ProfileViewController {
    func fetchUserProfile() {
        showActivityIndicator()
        guard let userEmail = Auth.auth().currentUser?.email else {
            showErrorAlert(message: "User email not found. Please log in again.")
            return
        }
        
        let database = Firestore.firestore()
        database.collection("users").document(userEmail).getDocument { documentSnapshot, error in
            if let error = error {
                print("Error fetching user profile: \(error.localizedDescription)")
                self.showErrorAlert(message: "Failed to fetch profile data.")
                return
            }
            
            guard let document = documentSnapshot, document.exists,
                  let userData = document.data() else {
                self.showErrorAlert(message: "User data not found.")
                return
            }
            
            // update the view with the fetched data
            if let name = userData["name"] as? String,
               let email = userData["email"] as? String,
               let phone = userData["phone"] as? String {
                self.profileScreen.labelName.text = "Hi \(name)!"
                self.profileScreen.labelEmail.text = "Email: \(email)"
                self.profileScreen.labelPhone.text = "Phone: \(phone)"
                self.hideActivityIndicator()
            } else {
                self.hideActivityIndicator()
                self.showErrorAlert(message: "Invalid user data.")
                
            }
        }
    }
    
    @objc func fetchTransactions() {
        showActivityIndicator()
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            print("User not logged in")
            return
        }

        FirebaseItemCommands.fetchItems { result in
            switch result {
            case .success(let fetchedItems):
                // filters transactions for items that have been sold
                let relevantItems = fetchedItems.filter { item in
                    (item.status == "usingSealTheDeal" || item.status == "usingTopBidder") &&
                    (item.sellerUserId == currentUserEmail || item.buyerUserId == currentUserEmail)
                }

                DispatchQueue.main.async {
                    self.transactions = relevantItems
                    self.profileScreen.transactionsTableView.reloadData()
                    self.updateEmptyList()
                    self.hideActivityIndicator()
                }
            case .failure(let error):
                self.hideActivityIndicator()
                print("Failed to fetch transactions: \(error.localizedDescription)")
            }
        }
    }
}

