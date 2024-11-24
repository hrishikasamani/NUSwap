//
//  FirebaseItemCommands.swift
//  NUSwap
//
//  Created by Karyn T on 11/23/24.
//

import FirebaseFirestore

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

