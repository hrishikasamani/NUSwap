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
    func sealTheDealForItem(documentID: String, userId: String) {
        let database = Firestore.firestore()
        let itemRef = database.collection("items").document(documentID)
        
        // Updating the basePrice field
        itemRef.updateData([
                "buyerUserId": userId,
                "status": "usingTopBidder"
            ]) { error in
                if let error = error {
                    print("Failed to update buyerUserId for document \(documentID): \(error.localizedDescription)")
                } else {
                    print("Successfully updated buyerUserId for document \(documentID).")
                    
                    print("yay you've the sold item!! (:")
                    self.sellToTopBidderOnScreen()
                    
                    NotificationCenter.default.post(name: Notification.Name("TransactionsUpdated"), object: nil)
                }
            }
    }
}
