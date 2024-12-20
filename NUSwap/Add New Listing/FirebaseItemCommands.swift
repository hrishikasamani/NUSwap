//
//  FirebaseItemCommands.swift
//  NUSwap
//
//  Created by Karyn T on 11/23/24.
//

import FirebaseFirestore

struct FirebaseItemCommands {
    
    static func fetchItemsRealTime(completion: @escaping (Result<[ItemStruct], Error>) -> Void) -> ListenerRegistration {
            let db = Firestore.firestore()
            
            // Set up a real-time listener for items collection
            return db.collection("items").addSnapshotListener { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let items = documents.compactMap { doc -> ItemStruct? in
                    try? doc.data(as: ItemStruct.self)
                }
                
                completion(.success(items))
            }
        }

    
    static func uploadNewItem(item: ItemStruct, imageURL: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let db = Firestore.firestore()
        
        // create a ID for the item document
        let itemId = db.collection("items").document().documentID
        
        do {
            var itemData = try Firestore.Encoder().encode(item)
            itemData["imageURL"] = imageURL
            itemData["itemId"] = itemId
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
                    let sealTheDealPrice = data["sealTheDealPrice"] as? Double,
                    let status = data["status"] as? String,
                    let imageURL = data["imageURL"] as? String
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
                    topBidPrice: topBidPrice,
                    imageURL: imageURL,
                    status: status
                )
            }
            completion(.success(items))
        }
    }
    

}

