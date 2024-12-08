//
//  TransactionsTableViewManager.swift
//  NUSwap
//
//  Created by Karyn T on 12/3/24.
//

import Foundation
import UIKit
import FirebaseAuth

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableView.identifier, for: indexPath) as? TransactionsTableView else {
            return UITableViewCell()
        }

        let transaction = transactions[indexPath.row]
        let currentUserEmail = Auth.auth().currentUser?.email ?? ""
        
        cell.itemImageView.image = UIImage(systemName: "photo")
        
        if let imageUrl = transaction.imageURL, let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil, let fetchedImage = UIImage(data: data) else {
                    print("Failed to load image from \(transaction.imageURL ?? ""): \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                DispatchQueue.main.async {
                    if let currentCell = tableView.cellForRow(at: indexPath) as? TransactionsTableView {
                        currentCell.itemImageView.image = fetchedImage
                    }
                }
            }.resume()
        }
        
        cell.selectionStyle = .none
        
        let isSeller = currentUserEmail == transaction.sellerUserId
        let price: String

        if transaction.status == "usingSealTheDeal" {
            price = "$\(transaction.sealTheDealPrice)"
        } else {
            price = "$\(transaction.topBidPrice ?? 0)"
        }

        cell.itemNameLabel.text = transaction.name
        cell.sealedForLabel.text = isSeller ? "Sold for \(price)" : "Bought for \(price)"
        cell.locationLabel.text = "Location: \(transaction.location)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Navigate to ProfileTabItemDescriptionViewController
        let selectedTransaction = transactions[indexPath.row]
        let profileTabItemDescriptionVC = ProfileTabItemDescriptionViewController()
        profileTabItemDescriptionVC.transaction = selectedTransaction // Pass the selected transaction
        
        navigationController?.pushViewController(profileTabItemDescriptionVC, animated: true)
    }

}
