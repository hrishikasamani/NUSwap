//
//  ProfileTabItemDescriptionViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 07/12/24.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class ProfileTabItemDescriptionViewController: UIViewController {
    var profileTabItemDescriptionView = ProfileTabItemDescriptionView()
    var transaction: ItemStruct? // Transaction to display
    var transactionListener: ListenerRegistration?
    var transactions: [ItemStruct] = []
    
    override func loadView() {
        view = profileTabItemDescriptionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ThemeManager.applyDefaultTheme(to: profileTabItemDescriptionView)
        self.navigationController?.navigationBar.tintColor = UIColor.label
        
        populateTransactionDetails()
        
        callTransactionListener()
        
        fetchBuyerOrSellerDetails()
    }
    
    func populateTransactionDetails() {
        guard let transaction = transaction else { return }
        
        profileTabItemDescriptionView.itemNameLabel.text = transaction.name
        profileTabItemDescriptionView.locationLabel.text = "Location: \(transaction.location)"
        profileTabItemDescriptionView.descriptionLabel.text = transaction.description
        
        // Set the initial price
        updatePriceLabel(for: transaction)
        
        // Load image
        if let imageUrlString = transaction.imageURL, let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                if let data = data, let fetchedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileTabItemDescriptionView.itemImage.image = fetchedImage
                    }
                }
            }.resume()
        }
    }
    
    func updatePriceLabel(for transaction: ItemStruct) {
        var priceText = "Price: "
        if transaction.status == "usingSealTheDeal" {
            priceText += "\(transaction.sealTheDealPrice)"
        } else if transaction.status == "usingTopBidder", let topBidPrice = transaction.topBidPrice {
            priceText += "\(topBidPrice)"
        } else {
            priceText += "N/A"
        }
        DispatchQueue.main.async {
            self.profileTabItemDescriptionView.priceLabel.text = priceText
        }
    }
        
        func callTransactionListener() {
            guard let currentUserEmail = Auth.auth().currentUser?.email else {
                print("User not logged in")
                return
            }
            
            transactionListener = FirebaseItemCommands.fetchItemsRealTime { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let fetchedItems):
                    let relevantItems = fetchedItems.filter { item in
                        (item.status == "usingSealTheDeal" || item.status == "usingTopBidder") &&
                        (item.sellerUserId == currentUserEmail || item.buyerUserId == currentUserEmail)
                    }
                    
                    DispatchQueue.main.async {
                        self.transactions = relevantItems
                        
                        // Check if the current transaction is updated
                        if let transactionId = self.transaction?.itemId,
                           let updatedTransaction = relevantItems.first(where: { $0.itemId == transactionId }) {
                            self.transaction = updatedTransaction
                            self.updatePriceLabel(for: updatedTransaction)
                        }
                    }
                case .failure(let error):
                    print("Failed to fetch real-time transactions: \(error.localizedDescription)")
                }
            }
        }
    }
    
