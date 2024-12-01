//
//  ListingsFBManager.swift
//  NUSwap
//
//  Created by Dhruv Doshi on 11/28/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension ListingsViewController {
    // Update fetchItems to filter for the current user's listings
    func fetchUserListingsFromFirebase(userEmail: String, completion: @escaping (Result<[ItemStruct], Error>) -> Void) {
        let db = Firestore.firestore()

        db.collection("items")
            .whereField("sellerUserId", isEqualTo: userEmail)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion(.success([])) // Return empty array if no items
                    return
                }

                let items: [ItemStruct] = documents.compactMap { document in
                    let data = document.data()
                    let itemId = document.documentID
                    guard
                        let name = data["name"] as? String,
                        let sellerUserId = data["sellerUserId"] as? String,
                        let category = data["category"] as? String,
                        let location = data["location"] as? String,
                        let description = data["description"] as? String,
                        let basePrice = data["basePrice"] as? Double,
                        let sealTheDealPrice = data["sealTheDealPrice"] as? Double,
                        data["buyerUserId"] == nil
                    else {
                        return nil
                    }

                    let buyerUserId = data["buyerUserId"] as? String
                    let topBidPrice = data["topBidPrice"] as? Double

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
                        topBidPrice: topBidPrice
                    )
                }
            completion(.success(items))
        }
    }
}
