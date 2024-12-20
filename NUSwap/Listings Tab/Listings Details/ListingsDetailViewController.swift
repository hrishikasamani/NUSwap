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
        
        ThemeManager.applyDefaultTheme(to: listingsDetailScreen)
        restoreButtonAppearance()
        restoreDividersAndTextboxesAppearance()
        
        // updates view with the item details
        if let item = item {
            listingsDetailScreen.itemNameLabel.text = item.name
            listingsDetailScreen.itemImage.image = UIImage(systemName: "photo")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
            listingsDetailScreen.sealDealPriceLabel.text = "$\(item.sealTheDealPrice)"
            listingsDetailScreen.locationLabel.text = item.location
            listingsDetailScreen.descriptionDetailsLabel.text = item.description
            
            let bidToShow = item.topBidPrice ?? item.basePrice
            listingsDetailScreen.topBidPriceLabel.text = "$\(bidToShow)"
            
            // Fetch and display the item image
            if let imageUrlString = item.imageURL, let imageUrl = URL(string: imageUrlString) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                    if let error = error {
                        print("Failed to load image: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let data = data, let fetchedImage = UIImage(data: data) else {
                        print("Failed to decode image data")
                        return
                    }
                    
                    // Update the UIImageView on the main thread
                    DispatchQueue.main.async {
                        self?.listingsDetailScreen.itemImage.image = fetchedImage
                    }
                }.resume()
            }
        }
        
        // button actions
        listingsDetailScreen.sellToTopBidButton.addTarget(self, action: #selector(sellToTopBidAction), for: .touchUpInside)
        
        listingsDetailScreen.deleteListingButton.addTarget(self, action: #selector(deleteListingAction), for: .touchUpInside)
    }
    
    func restoreButtonAppearance() {
        listingsDetailScreen.sellToTopBidButton.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 0/255, alpha: 1)
        listingsDetailScreen.sellToTopBidButton.setTitleColor(.white, for: .normal)

        listingsDetailScreen.deleteListingButton.backgroundColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)
        listingsDetailScreen.deleteListingButton.setTitleColor(.white, for: .normal)
    }
    
    func restoreDividersAndTextboxesAppearance() {
        listingsDetailScreen.bidsVerticalDivider.backgroundColor = .lightGray
        listingsDetailScreen.locationDivider.backgroundColor = .lightGray
        listingsDetailScreen.descriptionDivider.backgroundColor = .lightGray
        listingsDetailScreen.bidsHorizontalDivider.backgroundColor = .lightGray
    }

    
    // sell item to top bid button tapped
    @objc func sellToTopBidAction() {
        // get the buyer user id of the top bidder
        getMostRecentBidder(documentID: self.item?.itemId ?? "missingItemId") { buyerUserId in
            if let buyerUserId = buyerUserId {
                self.sealTheDealForItem(documentID: self.item?.itemId ?? "missing", userId: buyerUserId)
            } else {
                self.showErrorAlert(message: "No bidder found for this item yet.")
            }
        }
    }
    
    // update button to "sold" after selling item to top bidder
    func sellToTopBidderOnScreen() {
        DispatchQueue.main.async {
            self.listingsDetailScreen.sellToTopBidButton.isEnabled = false
            self.listingsDetailScreen.sellToTopBidButton.setTitle("SOLD!", for: .normal)
        }
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

    
    // Show an alert with the given message
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
