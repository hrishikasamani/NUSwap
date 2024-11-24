//
//  FirebaseNewListing.swift
//  NUSwap
//
//  Created by Karyn T on 11/23/24.
//

import FirebaseAuth

extension NewListingViewController {
    @objc func addListing() {
        guard let name = newListingScreen.productName.text, !name.isEmpty,
              let priceText = newListingScreen.priceTextField.text, let basePrice = Double(priceText),
              let sealDealText = newListingScreen.sealDealTextField.text, let sealDealPrice = Double(sealDealText),
              let location = newListingScreen.locationTextField.text, !location.isEmpty,
              let description = newListingScreen.detailsTextField.text, !description.isEmpty else {
            showErrorAlert(message: "You need to fill out all fields.")
            return
        }

        if sealDealPrice < basePrice {
            showErrorAlert(message: "Seal the Deal price must be equal to or greater than Base Price.")
            return
        }

        if !validateLocation(location) {
            showErrorAlert(message: "Location must be in 'City, State' format (e.g., 'Boston, MA').")
            return
        }

        guard let currentUser = Auth.auth().currentUser else {
            showErrorAlert(message: "You need to log in to create a listing.")
            return
        }

        let newItem = ItemStruct(
            name: name,
            sellerUserId: currentUser.email ?? "",
            buyerUserId: nil,
            category: selectedType,
            location: location,
            description: description,
            basePrice: basePrice,
            sealTheDealPrice: sealDealPrice,
            topBid: nil
        )

        FirebaseItemCommands.uploadNewItem(item: newItem) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    // Notify ListingsViewController with the new item
                    NotificationCenter.default.post(name: NSNotification.Name("NewListingAdded"), object: newItem)
                    
                    // Navigate back to ListingsViewController
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self.showErrorAlert(message: "Failed to upload listing: \(error.localizedDescription)")
                }
            }
        }

    }

    func validateLocation(_ location: String) -> Bool {
        let locationFormat = "^[A-Za-z\\s]+,\\s*[A-Za-z]+$"
        let locationPredicate = NSPredicate(format: "SELF MATCHES %@", locationFormat)
        return locationPredicate.evaluate(with: location)
    }
}
