//
//  ListingDetailsFirebaseManager.swift
//  NUSwap
//
//  Created by Dhruv Doshi on 11/28/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension ListingsDetailViewController {
    func getMostRecentBidder(documentID: String, completion: @escaping (String?) -> Void) {
        let database = Firestore.firestore()
        let bidsRef = database.collection("items").document(documentID).collection("bids")
        
        // Query to get the most recent bid based on timestamp
        bidsRef.order(by: "timestamp", descending: true).limit(to: 1).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching the most recent bid: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let documents = snapshot?.documents, let mostRecentBid = documents.first else {
                print("No bids found for document \(documentID)")
                completion(nil)
                return
            }
            
            // Extract buyerUserId from the most recent bid
            let data = mostRecentBid.data()
            if let buyerUserId = data["userId"] as? String {
                completion(buyerUserId)
            } else {
                print("buyerUserId not found in the most recent bid")
                completion(nil)
            }
        }
    }
    
    // update item status and bidder info to firestore when item is sold
    func soldToTopBidder(itemId: String, updatedBidPrice: Double) {
        let itemRef = Firestore.firestore().collection("items").document(itemId)
        
        // update the bid price
        itemRef.updateData(["topBidPrice": updatedBidPrice]) { [weak self] error in
            if let error = error {
                print("Failed to update topBidPrice: \(error.localizedDescription)")
                self?.showErrorAlert(message: "Failed to seal the deal. Please try again.")
                return
            }
            
            print("Successfully updated topBidPrice for item \(itemId).")
            
            // get most recent bidder
            self?.getMostRecentBidder(documentID: itemId) { buyerUserId in
                guard let self = self else { return }
                guard let buyerUserId = buyerUserId else {
                    print("No valid buyer found for this item.")
                    self.showErrorAlert(message: "No bidder found for this item.")
                    return
                }
                
                // update item status and button to "SOLD"
                Firestore.firestore().collection("items").document(itemId).updateData([
                    "status": "sealed",
                    "buyerUserId": buyerUserId
                ]) { error in
                    if let error = error {
                        print("Failed to seal the deal for document \(itemId): \(error.localizedDescription)")
                        self.showErrorAlert(message: "Failed to seal the deal. Please try again.")
                        return
                    }
                    
                    print("Successfully sealed the deal for item \(itemId).")
                    self.sellToTopBidderOnScreen()
                }
            }
        }
    }
}
