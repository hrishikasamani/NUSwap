//
//  HomePageViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 27/10/24.
//

import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController {
    var homePageView = HomePageView()
    var items: [ItemStruct] = []

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
        fetchListings()
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
                // filters out items where the user is the seller & with status "sealed"
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
