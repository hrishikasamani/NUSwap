//
//  ProfileTabItemDescriptionFirebaseManager.swift
//  NUSwap
//
//  Created by Preksha Patil on 07/12/24.
//

import FirebaseAuth
import FirebaseFirestore

extension ProfileTabItemDescriptionViewController {
    func fetchUserDetails(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let database = Firestore.firestore()
        database.collection("users").document(userId).getDocument { documentSnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = documentSnapshot?.data() else {
                completion(.failure(NSError(domain: "NoData", code: 404, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
    }

    func fetchBuyerOrSellerDetails() {
        guard let transaction = transaction else { return }
        let currentUserEmail = Auth.auth().currentUser?.email ?? ""
        
        // Determine whether to fetch buyer or seller details
        let userIdToFetch = currentUserEmail == transaction.sellerUserId ? transaction.buyerUserId : transaction.sellerUserId

        guard let userId = userIdToFetch else {
            profileTabItemDescriptionView.buyerSellerDetailsLabel.text = "No buyer or seller details available."
            return
        }
        
        fetchUserDetails(userId: userId) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let name = data["name"] as? String ?? "N/A"
                    let email = data["email"] as? String ?? "N/A"
                    let phone = data["phone"] as? String ?? "N/A"
                    
                    self?.profileTabItemDescriptionView.buyerSellerDetailsLabel.text = """
                    \(currentUserEmail == transaction.sellerUserId ? "Buyer" : "Seller") Details:
                    Name: \(name)
                    Email: \(email)
                    Phone: \(phone)
                    """
                }
            case .failure(let error):
                print("Failed to fetch user details: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.profileTabItemDescriptionView.buyerSellerDetailsLabel.text = "Failed to load user details."
                }
            }
        }
    }
}
