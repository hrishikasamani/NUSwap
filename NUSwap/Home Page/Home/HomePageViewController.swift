//
//  HomePageViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 27/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomePageViewController: UIViewController {
    var homePageView = HomePageView()
    var items: [ItemStruct] = []
    var itemListener: ListenerRegistration?
    
    override func loadView() {
        view = homePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .white
        fetchListings()
        
        homePageView.tableViewHome.delegate = self
        homePageView.tableViewHome.dataSource = self
        
        ThemeManager.applyDefaultTheme(to: homePageView)
        
        // Observe new listing notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewListingNotification(_:)), name: NSNotification.Name("NewListingAdded"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewListing)
        )
        
        // Start real-time listener
        itemListener = FirebaseItemCommands.fetchItemsRealTime { [weak self] result in
            switch result {
            case .success(let fetchedItems):
                guard let self = self else { return }
                self.items = fetchedItems.filter { $0.status == "available" && $0.sellerUserId != Auth.auth().currentUser?.email }
                DispatchQueue.main.async {
                    self.homePageView.tableViewHome.reloadData()
                    self.updateEmptyList()
                }
            case .failure(let error):
                print("Failed to fetch real-time updates: \(error.localizedDescription)")
            }
        }
    }
    
    // re-fetches data whenever view reloads
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reapply the theme every time the view appears
        ThemeManager.applyDefaultTheme(to: homePageView)
        fetchListings()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func addNewListing() {
        let newListingVC = NewListingViewController()
        navigationController?.pushViewController(newListingVC, animated: true)
    }
    
    @objc func fetchListings() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            print("User email not found")
            return
        }
        
        FirebaseItemCommands.fetchItems { result in
            switch result {
            case .success(let fetchedItems):
                // filters out items where the user is the seller & when item has already been sold
                self.items = fetchedItems.filter { $0.sellerUserId != currentUserEmail && $0.status == "available" }
                DispatchQueue.main.async {
                    self.homePageView.tableViewHome.reloadData()
                    self.updateEmptyList()
                }
            case .failure(let error):
                print("Failed to fetch listings: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func handleNewListingNotification(_ notification: Notification) {
        if let newItem = notification.object as? ItemStruct {
            // Append the new item to the list
            self.items.append(newItem)
            DispatchQueue.main.async {
                self.homePageView.tableViewHome.reloadData()
            }
        }
    }
    
    func updateEmptyList() {
        homePageView.emptyListLabel.isHidden = !items.isEmpty
        homePageView.tableViewHome.isHidden = items.isEmpty
    }
}
    
//    func applyTheme(isDarkMode: Bool) {
//        if let window = UIApplication.shared.connectedScenes
//            .compactMap({ $0 as? UIWindowScene })
//            .first?.windows.first {
//            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
//        }
//        // Change the navigation bar's appearance
//        UINavigationBar.appearance().barStyle = isDarkMode ? .black : .default
//        UINavigationBar.appearance().tintColor = isDarkMode ? .white : .black
//        
//        homePageView.backgroundColor = isDarkMode ? UIColor.black : UIColor.white
//        homePageView.tableViewHome.backgroundColor = isDarkMode ? UIColor.black : UIColor.white
//        // Update labels and other text elements
//        updateTextColors(for: homePageView, isDarkMode: isDarkMode)
//    }
//
//    func updateTextColors(for view: UIView, isDarkMode: Bool) {
//        let textColor = isDarkMode ? UIColor.white : UIColor.black
//        homePageView.emptyListLabel.textColor = textColor
//        // Recursively update subviews
//        for subview in view.subviews {
//            updateTextColors(for: subview, isDarkMode: isDarkMode)
//        }
//    }
