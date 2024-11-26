//
//  ItemDescriptionViewViewController.swift
//  NUSwap
//
//  Created by Dhruv Doshi on 10/27/24.
//

import UIKit
import FirebaseAuth

class ItemDescriptionViewController: UIViewController {
    var itemDescriptionScreen = ItemDescriptionView()
    var item: ItemStruct? // Accept ItemStruct here

    override func loadView() {
        view = itemDescriptionScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        
        // Button actions
        itemDescriptionScreen.placeBidButton.addTarget(self, action: #selector(placeNewBidAction), for: .touchUpInside)
        
        itemDescriptionScreen.sealDealButton.addTarget(self, action: #selector(sealTheDealAction), for: .touchUpInside)

        // Update the view with the item details
        if let item = item {
            itemDescriptionScreen.itemNameLabel.text = item.name
            itemDescriptionScreen.itemImage.image = UIImage(systemName: "photo") // Placeholder image
            itemDescriptionScreen.topBidPriceLabel.text = "$\(String(describing: item.topBid ?? 0))"
            itemDescriptionScreen.sealDealPriceLabel.text = "$\(item.sealTheDealPrice)"
            itemDescriptionScreen.locationLabel.text = item.location
            itemDescriptionScreen.descriptionDetailsLabel.text = item.description
            itemDescriptionScreen.sealDealButton.setTitle("Seal the Deal for $\(item.sealTheDealPrice)", for: .normal)
        }
    }
    
    // MARK: - Place new bid funtionality
    @objc func placeNewBidAction() {
        let newBidAmount = Double(itemDescriptionScreen.newBidTextField.text ?? "0")
        
        if newBidAmount != 0 && validateNewBid(newBidAmount: newBidAmount ?? 0){
            // update the base price
            updateBasePriceForItem(documentID: item?.itemId ?? "missing", newBidPrice: newBidAmount ?? 0)
            
            // update the bids collection
            addNewBidForItem(documentID: item?.itemId ?? "missing", newBidPrice: newBidAmount ?? 0, userId: Auth.auth().currentUser?.email ?? "missing")
        }
        else {
            showErrorAlert(message: "Invalid bid amount.")
        }
        
    }
    
    // MARK: - Seal the Deal funtionality
    @objc func sealTheDealAction() {
        sealTheDealForItem(documentID: item?.itemId ?? "missing", userId: Auth.auth().currentUser?.email ?? "missing")
        
    }
    
    func sealTheDealOnScreen(){
        UIView.animate(withDuration: 0.2, animations: {
            self.itemDescriptionScreen.sealDealPriceLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.itemDescriptionScreen.sealDealPriceLabel.transform = CGAffineTransform.identity
            }
        }
        itemDescriptionScreen.sealDealButton.isEnabled = false
        itemDescriptionScreen.sealDealButton.setTitle("ALREADY YOURS!", for: .normal)
        // navigate to the Biddings screen AFTER sealthedeal is success??
    }
    
    func updateTopBidOnScreen(newBidAmount: Double) {
        // Update the text fields
        itemDescriptionScreen.topBidPriceLabel.text = String("$\(newBidAmount)")
        itemDescriptionScreen.newBidTextField.text = ""
        item?.topBid = newBidAmount

        
        UIView.animate(withDuration: 0.2, animations: {
            self.itemDescriptionScreen.topBidPriceLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.itemDescriptionScreen.topBidPriceLabel.transform = CGAffineTransform.identity
            }
        }
    }

    
    func validateNewBid(newBidAmount: Double) -> Bool {
        if newBidAmount <= item?.basePrice ?? 0 || newBidAmount <= item?.topBid ?? 0{
            return false
        }
        
        if newBidAmount >= item?.sealTheDealPrice ?? 10000000000{
            return false
        }
        
        return true
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
