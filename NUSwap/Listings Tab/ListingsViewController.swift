//
//  ListingsViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 04/11/24.
//

import UIKit
import FirebaseAuth

class ListingsViewController: UIViewController {
    
    var ListingsScreen = ListingsView()
    var listedItems: [ItemStruct] = []
    
    override func loadView() {
        view = ListingsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Listings"
        view.backgroundColor = .white
        fetchUserListings()
        
        ListingsScreen.tableViewListings.delegate = self
        ListingsScreen.tableViewListings.dataSource = self
        
        // Observe new listing notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewListingNotification(_:)), name: NSNotification.Name("NewListingAdded"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewListing)
        )
    }
    
    // re-fetches data whenever view reloads
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
//            fetchUserListings()
        }
    
    @objc func addNewListing() {
        let newListingVC = NewListingViewController()
        navigationController?.pushViewController(newListingVC, animated: true)
    }
    
    @objc func fetchUserListings() {
        guard let currentUser = Auth.auth().currentUser else {
            print("User not logged in")
            return
        }

        fetchUserListingsFromFirebase(userEmail: currentUser.email ?? "") { result in
            switch result {
            case .success(let items):
                self.listedItems = items
                DispatchQueue.main.async {
                    self.ListingsScreen.tableViewListings.reloadData()
                    self.updateEmptyList()
                }
            case .failure(let error):
                print("Failed to fetch user listings: \(error.localizedDescription)")
            }
        }
    }

    @objc func handleNewListingNotification(_ notification: Notification) {
        if let newItem = notification.object as? ItemStruct {
            // Append the new item at the bottom of the list
            self.listedItems.append(newItem)
            DispatchQueue.main.async {
                self.ListingsScreen.tableViewListings.reloadData()
            }
        }
    }
    
    func updateEmptyList() {
        ListingsScreen.emptyListLabel.isHidden = !listedItems.isEmpty
        ListingsScreen.tableViewListings.isHidden = listedItems.isEmpty
    }

}

