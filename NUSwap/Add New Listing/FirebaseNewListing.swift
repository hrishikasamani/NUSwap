//
//  FirebaseNewListing.swift
//  NUSwap
//
//  Created by Karyn T on 11/23/24.
//

import FirebaseAuth
import FirebaseStorage
import UIKit

extension NewListingViewController {
    @objc func addListing() {
        // check item name
        let productName = newListingScreen.productName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard productName.count <= 30, !productName.isEmpty else {
            showErrorAlert(message: "Item name must be 30 characters or less and cannot be empty.")
            return
        }
        
        // check price
        guard let formattedPrice = formatPrice(newListingScreen.priceTextField.text),
                  let basePrice = Double(formattedPrice), basePrice >= 0 else {
                showErrorAlert(message: "Invalid Base Price format; should be in 'XX.XX' format with 2 decimal places (e.g., '52.88').")
                return
            }
        
        // check seal deal price
        guard let formattedSealDeal = formatPrice(newListingScreen.sealDealTextField.text),
                  let sealDealPrice = Double(formattedSealDeal), sealDealPrice >= basePrice else {
                showErrorAlert(message: "Invalid Seal the Deal price; should be in 'XX.XX' format with 2 decimal places and at least equal to the Base Price.")
                return
            }
        
        // karyn to team: cannot compute string > double
        print("formatted: \(formattedPrice) (\(basePrice))")
        print("formatted: \(formattedSealDeal) (\(sealDealPrice))")


        // check location
        let location = newListingScreen.locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard location.count <= 30, !location.isEmpty else {
            showErrorAlert(message: "Location must be 30 characters or less and cannot be empty.")
            return
        }
        guard self.validateLocation(location) else {
            showErrorAlert(message: "Location must be in 'City, State' format (ie. 'Boston, MA').")
            return
        }

        // check description
        let description = newListingScreen.detailsTextField.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard description.count <= 200, !description.isEmpty, description != "Enter detailed description here..." else {
            showErrorAlert(message: "Details must be 200 characters or less and cannot be empty.")
            return
        }

        // check image
        guard let imageToUpload = selectedImage else {
            showErrorAlert(message: "You need to add a photo to list your item on the marketplace.")
            return
        }
        guard let imageData = imageToUpload.jpegData(compressionQuality: 0.8) else {
            showErrorAlert(message: "Unable to process the image.")
            return
        }

        // Create a unique file name for the image
        let fileName = "\(UUID().uuidString).jpg"

        // Get a reference to Firebase Storage
        let storageRef = Storage.storage().reference().child("item_images/\(fileName)")

        // Upload the image
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                self.showErrorAlert(message: "Upload failed: \(error.localizedDescription)")
                return
            }
            
            // Fetch the download URL
            storageRef.downloadURL { url, error in
                if let error = error {
                    self.showErrorAlert(message: "Failed to retrieve download URL: \(error.localizedDescription)")
                    return
                }

                guard let downloadURL = url else {
                    self.showErrorAlert(message: "Download URL is nil.")
                    return
                }

                self.uploadedImageURL = downloadURL.absoluteString
                print("Image uploaded successfully. URL: \(self.uploadedImageURL ?? "No URL")")

                guard let currentUser = Auth.auth().currentUser else {
                    self.showErrorAlert(message: "You need to log in to create a listing.")
                    return
                }

                // Create the item object
                let newItem = ItemStruct(
                    name: productName,
                    sellerUserId: currentUser.email ?? "",
                    buyerUserId: nil,
                    category: self.selectedType,
                    location: location,
                    description: description,
                    basePrice: basePrice,
                    sealTheDealPrice: sealDealPrice,
                    topBidPrice: nil
                )

                // Upload the new item
                FirebaseItemCommands.uploadNewItem(item: newItem, imageURL: self.uploadedImageURL ?? "") { result in
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
        }
    }
    
    func formatPrice(_ input: String?) -> String? {
        guard let input = input?.trimmingCharacters(in: .whitespacesAndNewlines), !input.isEmpty else {
            return nil
        }

        // format "XX.XX" format and "XX.X"
        let priceRegex = "^[0-9]+(\\.[0-9]{0,2})?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", priceRegex)

        guard predicate.evaluate(with: input) else {
            return nil
        }

        // add ".00" if no decimal part
        if !input.contains(".") {
            return "\(input).00"
        } else if input.split(separator: ".")[1].count == 1 {
            // add an extra zero if there's only one digit after the decimal
            return "\(input)0"
        }
        return input
    }


    func validateLocation(_ location: String) -> Bool {
        let locationFormat = "^[A-Za-z\\s]+,\\s*[A-Za-z]+$"
        let locationPredicate = NSPredicate(format: "SELF MATCHES %@", locationFormat)
        return locationPredicate.evaluate(with: location)
    }
    
    func uploadImageToFirebase(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            showErrorAlert(message: "Unable to process the image.")
            return
        }
        
        // Create a unique file name for the image
        let fileName = "\(UUID().uuidString).jpg"
        
        // Get a reference to Firebase Storage
        let storageRef = Storage.storage().reference().child("item_images/\(fileName)")
        
        // Upload the image
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                self.showErrorAlert(message: "Upload failed: \(error.localizedDescription)")
                return
            }
            
            // Fetch the download URL
            storageRef.downloadURL { url, error in
                if let error = error {
                    self.showErrorAlert(message: "Failed to retrieve download URL: \(error.localizedDescription)")
                    return
                }
                
                guard let downloadURL = url else {
                    self.showErrorAlert(message: "Download URL is nil.")
                    return
                }
                
                self.uploadedImageURL = downloadURL.absoluteString // Save the URL in the local variable
                print("Image uploaded successfully. URL: \(self.uploadedImageURL ?? "No URL")")
            }
        }
    }
}
