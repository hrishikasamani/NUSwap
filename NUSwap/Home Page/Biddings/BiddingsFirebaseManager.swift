//
//  BiddingsFirebaseManager.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/27/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


struct BiddingsFirebaseManager{
    static func fetchBiddedItems(userEmail: String, completion: @escaping (Result<[ItemStruct], Error>) -> Void) {
        let db = Firestore.firestore()

        // Fetch all bids placed by the user
        db.collection("bids")
            .whereField("buyerUserId", isEqualTo: userEmail)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion(.success([])) // No bids found
                    return
                }

                // Extract item IDs from the bids
                let itemIds = documents.compactMap { $0.data()["itemId"] as? String }
                
                if itemIds.isEmpty {
                    completion(.success([])) // No items to fetch
                    return
                }

                // Fetch the items corresponding to these item IDs
                db.collection("items")
                    .whereField(FieldPath.documentID(), in: itemIds)
                    .getDocuments { snapshot, error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }

                        guard let itemDocuments = snapshot?.documents else {
                            completion(.success([])) // No items found
                            return
                        }

                        let items: [ItemStruct] = itemDocuments.compactMap { document in
                            let data = document.data()
                            let itemId = document.documentID
                            guard
                                let name = data["name"] as? String,
                                let sellerUserId = data["sellerUserId"] as? String,
                                let category = data["category"] as? String,
                                let location = data["location"] as? String,
                                let description = data["description"] as? String,
                                let basePrice = data["basePrice"] as? Double,
                                let sealTheDealPrice = data["sealTheDealPrice"] as? Double
                            else {
                                return nil
                            }

                            let buyerUserId = data["buyerUserId"] as? String
                            let topBid = data["topBid"] as? Double

                            return ItemStruct(
                                itemId: itemId,
                                name: name,
                                sellerUserId: sellerUserId,
                                buyerUserId: buyerUserId,
                                category: category,
                                location: location,
                                description: description,
                                basePrice: basePrice,
                                sealTheDealPrice: sealTheDealPrice,
                                topBid: topBid
                            )
                        }
                        completion(.success(items))
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
                let sealTheDealPrice = data["sealTheDealPrice"] as? Double
            else {
                return
            }

            let buyerUserId = data["buyerUserId"] as? String
            let topBid = data["topBid"] as? Double

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
                topBid: topBid
            )

            completion(.success(item))
        }
    }
}
