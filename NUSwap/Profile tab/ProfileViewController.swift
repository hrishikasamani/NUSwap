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
    let childProgressView = ProgressSpinnerViewController()
    
    var transactions: [ItemStruct] = []
    
    //MARK: patch the view of the controller to the DisplayView...
    override func loadView() {
        view = profileScreen
        profileScreen.transactionsTableView.dataSource = self
        profileScreen.transactionsTableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        profileScreen.toggle.addTarget(self, action: #selector(onToggleChanged), for: .valueChanged)
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
        // Set text color
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [.foregroundColor: UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)],
            for: .normal
        )
        
        fetchUserProfile()
        fetchTransactions()
        
        // Set the default theme based on saved preference
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        profileScreen.toggle.selectedSegmentIndex = isDarkMode ? 1 : 0
        applyTheme(isDarkMode: isDarkMode)
    }
    
    @objc func onToggleChanged(_ sender: UISegmentedControl) {
        let isDarkMode = sender.selectedSegmentIndex == 1
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        applyTheme(isDarkMode: isDarkMode)
    }

    func applyTheme(isDarkMode: Bool) {
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.first {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
        // Change the navigation bar's appearance
        UINavigationBar.appearance().barStyle = isDarkMode ? .black : .default
        UINavigationBar.appearance().tintColor = isDarkMode ? .white : .black
        
        profileScreen.backgroundColor = isDarkMode ? UIColor.black : UIColor.white
        
        // If you have other views with backgrounds, you should update their background color as well
        profileScreen.contentWrapper.backgroundColor = isDarkMode ? UIColor.black : UIColor.white
        
        // Update labels and other text elements
        updateTextColors(for: profileScreen, isDarkMode: isDarkMode)
    }
    
    func updateTextColors(for view: UIView, isDarkMode: Bool) {
        let textColor = isDarkMode ? UIColor.white : UIColor.black
        //profileScreen.labelName.textColor = textColor
        profileScreen.labelEmail.textColor = textColor
        profileScreen.labelPhone.textColor = textColor
        profileScreen.labelCompletedTransactions.textColor = textColor
        profileScreen.labelTransactionDescription.textColor = textColor
        profileScreen.emptyListLabel.textColor = textColor
        
        
        // Recursively update subviews
        for subview in view.subviews {
            updateTextColors(for: subview, isDarkMode: isDarkMode)
        }
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
            do {
                // Attempt to log the user out from Firebase
                try Auth.auth().signOut()
                
                // Navigate back to the login page
                let loginViewController = ViewController()
                let navController = UINavigationController(rootViewController: loginViewController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            } catch let error {
                // Handle any errors during sign out
                print("Error signing out: \(error.localizedDescription)")
                
                // Show an error alert to the user
                let errorAlert = UIAlertController(
                    title: "Logout Failed",
                    message: "Unable to log out at the moment. Please try again later.",
                    preferredStyle: .alert
                )
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
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
