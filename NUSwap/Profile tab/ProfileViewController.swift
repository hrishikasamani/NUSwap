//
//  ProfileViewController.swift
//  WA4_Doshi_6855
//
//  Created by Dhruv Doshi on 10/3/24.
//


import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class ProfileViewController: UIViewController {

    //MARK: creating instance of DisplayView...
    let profileScreen = ProfileView()
    
    var transactions: [ItemStruct] = []
    
    //MARK: patch the view of the controller to the DisplayView...
    override func loadView() {
        view = profileScreen
        profileScreen.transactionsTableView.dataSource = self
        profileScreen.transactionsTableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Profile"
        
        updateEmptyList()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetchTransactions),
            name: Notification.Name("TransactionsUpdated"),
            object: nil
        )
        
        // Add Logout button in the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(onLogoutButtonTapped)
        )
        
        fetchUserProfile()
        fetchTransactions()
    }
    
    @objc func onLogoutButtonTapped() {
        // Create the alert controller
        let alertController = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to logout?",
            preferredStyle: .alert
        )
        
        // Add "Cancel" action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Add "Logout" action
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            // Navigate back to the login page
            let loginViewController = ViewController()
            let navController = UINavigationController(rootViewController: loginViewController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
        alertController.addAction(logoutAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }

    
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func updateEmptyList() {
        let hasTransactions = !transactions.isEmpty
        profileScreen.emptyListLabel.isHidden = hasTransactions
        profileScreen.transactionsTableView.isHidden = !hasTransactions
    }

}
