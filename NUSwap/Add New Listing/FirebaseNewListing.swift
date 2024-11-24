//
//  FirebaseNewListing.swift
//  NUSwap
//
//  Created by Karyn T on 11/23/24.
//

import FirebaseAuth

extension NewListingViewController {
    @objc func addListing() {
        // validate user input
        guard let name = newListingScreen.productName.text, !name.isEmpty,
              let priceText = newListingScreen.priceTextField.text, let basePrice = Double(priceText),
              let sealDealText = newListingScreen.sealDealTextField.text, let sealDealPrice = Double(sealDealText),
              let location = newListingScreen.locationTextField.text, !location.isEmpty,
              let description = newListingScreen.detailsTextField.text, !description.isEmpty else {
            showErrorAlert(message: "You need to fill out all fields.")
            return
        }
        
        // seal the deal price needs to be greater than or equal to base price
        if sealDealPrice < basePrice {
                showErrorAlert(message: "Seal the Deal price must be equal to or greater than Base Price.")
                return
            }
        
        // validate location format
        if !validateLocation(location) {
            showErrorAlert(message: "Location must be in 'City, State' format (e.g., 'Boston, MA').")
            return
        }

        // get current user
        guard let currentUser = Auth.auth().currentUser else {
            showErrorAlert(message: "You need to log in in to create a listing.")
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
        
        print("successfully created object: \(newItem)")

        // call the upload function
        FirebaseItemCommands.uploadNewItem(item: newItem) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("good job, listing created (: ")
                case .failure(let error):
                    self.showErrorAlert(message: "failed to upload listing bc \(error.localizedDescription)") //failed here bc no auth
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

