//
//  FirebaseItemCommands.swift
//  NUSwap
//
//  Created by Karyn T on 11/23/24.
//

import FirebaseFirestore
import FirebaseAuth

struct FirebaseItemCommands {
    static func uploadNewItem(item: ItemStruct, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        
        // create a ID for the item document
        let itemId = db.collection("items").document().documentID
        
        do {
            let itemData = try Firestore.Encoder().encode(item)
            db.collection("items").document(itemId).setData(itemData) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                    print("upload successful")
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    // fetch all items
    static func fetchItems(completion: @escaping (Result<[ItemStruct], Error>) -> Void) {
        let db = Firestore.firestore()

        db.collection("items").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documents = snapshot?.documents else {
                completion(.success([])) // return empty array if no item
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
    
    // Update fetchItems to filter for the current user's listings
    static func fetchUserListings(userEmail: String, completion: @escaping (Result<[ItemStruct], Error>) -> Void) {
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

