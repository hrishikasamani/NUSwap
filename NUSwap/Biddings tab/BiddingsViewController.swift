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
    var biddedItems: [ItemStruct] = []
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

        BiddingsFirebaseManager.fetchUserBiddingsFromFirebase(userEmail: userEmail) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.biddedItems = items.filter { $0.status == "available" } // fetches only available items
                    print("Fetched items: \(self.biddedItems)")
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
        
        BiddingsFirebaseManager.fetchItemDetails(itemId: itemId) { result in
            switch result {
            case .success(let newItem):
                if newItem.status == "available" && !self.biddedItems.contains(where: { $0.itemId == newItem.itemId }) {
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
