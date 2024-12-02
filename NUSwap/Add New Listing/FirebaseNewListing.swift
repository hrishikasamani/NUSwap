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
        guard let name = newListingScreen.productName.text, !name.isEmpty,
              let priceText = newListingScreen.priceTextField.text, let basePrice = Double(priceText),
              let sealDealText = newListingScreen.sealDealTextField.text, let sealDealPrice = Double(sealDealText),
              let location = newListingScreen.locationTextField.text, !location.isEmpty,
              let description = newListingScreen.detailsTextField.text, !description.isEmpty,
              let imageToUpload = selectedImage else {
            showErrorAlert(message: "You need to fill out all fields.")
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
                
                self.uploadedImageURL = downloadURL.absoluteString // Save the URL in the local variable
                print("Image uploaded successfully. URL: \(self.uploadedImageURL ?? "No URL")")
                
                // Now store the item in the Firestore database
                if sealDealPrice < basePrice {
                    self.showErrorAlert(message: "Seal the Deal price must be equal to or greater than Base Price.")
                    return
                }

                if !self.validateLocation(location) {
                    self.showErrorAlert(message: "Location must be in 'City, State' format (e.g., 'Boston, MA').")
                    return
                }

                guard let currentUser = Auth.auth().currentUser else {
                    self.showErrorAlert(message: "You need to log in to create a listing.")
                    return
                }

                let newItem = ItemStruct(
                    name: name,
                    sellerUserId: currentUser.email ?? "",
                    buyerUserId: nil,
                    category: self.selectedType,
                    location: location,
                    description: description,
                    basePrice: basePrice,
                    sealTheDealPrice: sealDealPrice,
                    topBidPrice: nil
                )

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
