//
//  BiddingsFirebaseManager.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/27/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


struct BiddingsFirebaseManager {
    static func fetchUserBiddingsFromFirebase(userEmail: String, completion: @escaping (Result<[ItemStruct], Error>) -> Void) {
        let db = Firestore.firestore()
        var userBiddedItems: [ItemStruct] = []
        
        // Fetch all items
        db.collection("items").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let dispatchGroup = DispatchGroup()
            
            for document in documents {
                dispatchGroup.enter()
                let itemId = document.documentID
                
                // Fetch the highest bid for the item
                db.collection("items").document(itemId).collection("bids")
                    .order(by: "bidAmount", descending: true)
                    .limit(to: 1)
                    .getDocuments { bidsSnapshot, error in
                        if let error = error {
                            print("Error fetching bids for item \(itemId): \(error.localizedDescription)")
                            dispatchGroup.leave()
                            return
                        }
                        
                        guard let topBid = bidsSnapshot?.documents.first,
                              let topBidder = topBid.data()["userId"] as? String,
                              topBidder == userEmail else {
                            // Skip if the user is not the top bidder
                            dispatchGroup.leave()
                            return
                        }
                        
                        // User is the top bidder, add the item
                        let data = document.data()
                        guard
                            let name = data["name"] as? String,
                            let sellerUserId = data["sellerUserId"] as? String,
                            let category = data["category"] as? String,
                            let location = data["location"] as? String,
                            let description = data["description"] as? String,
                            let basePrice = data["basePrice"] as? Double,
                            let sealTheDealPrice = data["sealTheDealPrice"] as? Double,
                            let imageURL = data["imageURL"] as? String
                        else {
                            dispatchGroup.leave()
                            return
                        }
                        
                        let buyerUserId = data["buyerUserId"] as? String
                        let topBidPrice = data["topBidPrice"] as? Double
                        
                        let item = ItemStruct(
                            itemId: itemId,
                            name: name,
                            sellerUserId: sellerUserId,
                            buyerUserId: buyerUserId,
                            category: category,
                            location: location,
                            description: description,
                            basePrice: basePrice,
                            sealTheDealPrice: sealTheDealPrice,
                            topBidPrice: topBidPrice,
                            imageURL: imageURL
                        )
                        userBiddedItems.append(item)
                        dispatchGroup.leave()
                    }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(.success(userBiddedItems))
            }
        }
    }
    
    static func fetchItemDetails(itemId: String, completion: @escaping (Result<ItemStruct, Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("items").document(itemId).getDocument { document, error in
            if let error = error {
                completion(.failure(error)) // Return the error if fetching fails
                return
            }
            
            guard let document = document, document.exists,
                  let data = document.data() else {
                completion(.failure(NSError(domain: "ItemNotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "Item not found."])))
                return
            }
                
            guard
                let name = data["name"] as? String,
                let sellerUserId = data["sellerUserId"] as? String,
                let category = data["category"] as? String,
                let location = data["location"] as? String,
                let description = data["description"] as? String,
                let basePrice = data["basePrice"] as? Double,
                let sealTheDealPrice = data["sealTheDealPrice"] as? Double,
                let imageURL = data["imageURL"] as? String
            else {
                return
            }
            
            let buyerUserId = data["buyerUserId"] as? String
            let topBidPrice = data["topBidPrice"] as? Double
            print("image url here:",imageURL)
            
            let item = ItemStruct(
                itemId: itemId,
                name: name,
                sellerUserId: sellerUserId,
                buyerUserId: buyerUserId,
                category: category,
                location: location,
                description: description,
                basePrice: basePrice,
                sealTheDealPrice: sealTheDealPrice,
                topBidPrice: topBidPrice,
                imageURL: imageURL
            )
            
            completion(.success(item))
        }
    }
}
