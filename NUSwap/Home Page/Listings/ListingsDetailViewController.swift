//
//  ListingsDetailViewController.swift
//  NUSwap
//
//  Created by Karyn T on 11/26/24.
//

import UIKit
import FirebaseFirestore

class ListingsDetailViewController: UIViewController {
    
    var listingsDetailScreen = ListingsDetailView()
    var item: ItemStruct?
    
    override func loadView() {
        view = listingsDetailScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // updates view with the item details
        if let item = item {
            listingsDetailScreen.itemNameLabel.text = item.name
            listingsDetailScreen.itemImage.image = UIImage(systemName: "photo") // placeholder image
            listingsDetailScreen.sealDealPriceLabel.text = "$\(item.sealTheDealPrice)"
            listingsDetailScreen.locationLabel.text = item.location
            listingsDetailScreen.descriptionDetailsLabel.text = item.description
            
            let bidToShow = item.topBid ?? item.basePrice
            listingsDetailScreen.topBidPriceLabel.text = "$\(bidToShow)"
        }
        
        // button actions
        listingsDetailScreen.sellToTopBidButton.addTarget(self, action: #selector(sellToTopBidAction), for: .touchUpInside)
        
        listingsDetailScreen.deleteListingButton.addTarget(self, action: #selector(deleteListingAction), for: .touchUpInside)
    }
    
    // sell item to top bid button tapped
    @objc func sellToTopBidAction() {
        print("yay u made moneyyyyyy!")
    }
    
    // delete listing button tapped
    @objc func deleteListingAction() {
        guard let item = item else { return }

        // ui alert
        let alert = UIAlertController(
            title: "Delete Listing",
            message: "Are you sure you want to delete this listing? This action cannot be undone.",
            preferredStyle: .alert
        )

        // cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // delete action
        alert.addAction(UIAlertAction(title: "Delete Listing", style: .destructive) { [weak self] _ in
            Firestore.firestore().collection("items").document(item.itemId).delete { error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Failed to delete listing with documentID \(item.itemId): \(error.localizedDescription)")
                        let errorAlert = UIAlertController(
                            title: "Error",
                            message: "Failed to delete the listing. Please try again.",
                            preferredStyle: .alert
                        )
                        errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(errorAlert, animated: true)
                    } else {
                        print("deleted listing with documentID \(item.itemId).")
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        })
        present(alert, animated: true)
    }
}
