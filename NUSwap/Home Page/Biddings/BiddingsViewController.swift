//
//  BiddingsViewController.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/27/24.
//

import UIKit
import FirebaseAuth

class BiddingsViewController: UIViewController {
    
    var BiddingsScreen = BiddingsView()
    var biddedItems: [ItemStruct] = [
        //        ItemStruct(name: "Item 1", sellerUserId: "seller1@example.com", category: "Electronics", location: "Boston, MA", description: "Description for item 1", basePrice: 500, sealTheDealPrice: 1200),
        //        ItemStruct(name: "Item 3", sellerUserId: "seller3@example.com", category: "Furniture", location: "Somerville, MA", description: "Description for item 3", basePrice: 250, sealTheDealPrice: 700)
    ]
    var item: ItemStruct?
    
    override func loadView() {
        view = BiddingsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Biddings"
        view.backgroundColor = .white
        fetchUserBiddings()
        
        BiddingsScreen.tableViewBiddings.delegate = self
        BiddingsScreen.tableViewBiddings.dataSource = self
        
        // Observe new listing notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewBiddingNotification(_:)), name: NSNotification.Name("NewBiddingAdded"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserBiddings()
    }
    
    @objc func fetchUserBiddings() {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("User not logged in")
            return
        }

        FirebaseItemCommands.fetchBiddedItems(userEmail: userEmail) { result in
            switch result {
            case .success(let items):
                print("Before fetch: \(self.biddedItems)")
                
                DispatchQueue.main.async {
                    self.updateEmptyList()
                    self.BiddingsScreen.tableViewBiddings.reloadData()
                }
            case .failure(let error):
                print("Error fetching bidded items: \(error.localizedDescription)")
            }
        }
    }

    
    @objc func handleNewBiddingNotification(_ notification: Notification) {
        guard let itemId = notification.object as? String else { return }
        print("Received itemId: \(itemId)")
        
        FirebaseItemCommands.fetchItemDetails(itemId: itemId) { result in
            switch result {
            case .success(let newItem):
                if !self.biddedItems.contains(where: { $0.itemId == newItem.itemId }) {
                    self.biddedItems.append(newItem)
                    DispatchQueue.main.async {
                        self.updateEmptyList()
                        self.BiddingsScreen.tableViewBiddings.reloadData()
                    }
                }
            case .failure(let error):
                print("Error fetching item details: \(error.localizedDescription)")
            }
        }
    }

    
    func updateEmptyList() {
        BiddingsScreen.emptyListLabel.isHidden = !biddedItems.isEmpty
        BiddingsScreen.tableViewBiddings.isHidden = biddedItems.isEmpty
    }
    
}
