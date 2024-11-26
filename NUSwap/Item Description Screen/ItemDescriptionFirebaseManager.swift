//
//  ItemDescriptionFirebaseManager.swift
//  NUSwap
//
//  Created by Dhruv Doshi on 11/25/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension ItemDescriptionViewController{
    
    func updateBasePriceForItem(documentID: String, newBidPrice: Double) {
        let database = Firestore.firestore()
        let itemRef = database.collection("items").document(documentID)
        
        // Updating the basePrice field
        itemRef.updateData(["topBidPrice": newBidPrice]) { error in
            if let error = error {
                print("Failed to update basePrice for document \(documentID): \(error.localizedDescription)")
            } else {
                print("Successfully updated basePrice for document \(documentID).")
                self.updateTopBidOnScreen(newBidAmount: newBidPrice)
            }
        }
        
        
    }
    
    func addNewBidForItem(documentID: String, newBidPrice: Double, userId: String) {
        let database = Firestore.firestore()
        let itemBiddingRef = database.collection("items").document(documentID).collection("bids")
        
        let bidData: [String: Any] = [
            "userId": userId,
            "bidAmount": newBidPrice,
            "timestamp": Timestamp()
        ]
        
        itemBiddingRef.addDocument(data: bidData) { error in
            if let error = error {
                print("Error adding new bid: \(error.localizedDescription)")
            } else {
                print("New bid successfully added for item with documentID \(documentID).")
            }
        }
    }
    
    func sealTheDealForItem(documentID: String, userId: String) {
        let database = Firestore.firestore()
        let itemRef = database.collection("items").document(documentID)
        
        // Updating the basePrice field
        itemRef.updateData(["buyerUserId": userId]) { error in
            if let error = error {
                print("Failed to update buyerUserId for document \(documentID): \(error.localizedDescription)")
            } else {
                print("Successfully updated buyerUserId for document \(documentID).")
                self.sealTheDealOnScreen()
            }
        }
    }


    
}
