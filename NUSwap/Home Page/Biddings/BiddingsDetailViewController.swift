//
//  BiddingsDetailsViewController.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/27/24.
//

import UIKit
import FirebaseAuth

class BiddingsDetailViewController: UIViewController {
    
    var BiddingDetailsScreen = BiddingsDetailView()
    var item: ItemStruct? // Accept ItemStruct here

    override func loadView() {
        view = BiddingDetailsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Button actions
        BiddingDetailsScreen.placeBidButton.addTarget(self, action: #selector(placeNewBidAction), for: .touchUpInside)
        
        BiddingDetailsScreen.sealDealButton.addTarget(self, action: #selector(sealTheDealAction), for: .touchUpInside)

        // Update the view with the item details
        if let item = item {
            BiddingDetailsScreen.itemNameLabel.text = item.name
            BiddingDetailsScreen.itemImage.image = UIImage(systemName: "photo") // Placeholder image
            BiddingDetailsScreen.topBidPriceLabel.text = "$\(String(describing: item.topBid ?? 0))"
            BiddingDetailsScreen.sealDealPriceLabel.text = "$\(item.sealTheDealPrice)"
            BiddingDetailsScreen.locationLabel.text = item.location
            BiddingDetailsScreen.descriptionDetailsLabel.text = item.description
            BiddingDetailsScreen.sealDealButton.setTitle("Seal the Deal for $\(item.sealTheDealPrice)", for: .normal)
        }
    }
    
    // MARK: - Place new bid funtionality
    @objc func placeNewBidAction() {
        let newBidAmount = Double(BiddingDetailsScreen.newBidTextField.text ?? "0")
        
        if newBidAmount != 0 && validateNewBid(newBidAmount: newBidAmount ?? 0){
            // update the base price
            updateBasePriceForItem(documentID: item?.itemId ?? "missing", newBidPrice: newBidAmount ?? 0)
            
            // update the bids collection
            addNewBidForItem(documentID: item?.itemId ?? "missing", newBidPrice: newBidAmount ?? 0, userId: Auth.auth().currentUser?.email ?? "missing")
            
            if var updatedItem = item {
                updatedItem.topBid = newBidAmount // Update the top bid locally
                NotificationCenter.default.post(name: NSNotification.Name("NewBiddingAdded"), object: updatedItem.itemId)
            }
            
            //navigateToBiddingsViewController()
        }
        else {
            showErrorAlert(message: "Invalid bid amount.")
        }
        
    }
    
    func navigateToBiddingsViewController() {
        self.navigationController?.popViewController(animated: true)
        // Assuming the 'MainTabBarController' is the root view controller
        if let mainTabBarController = self.tabBarController as? MainTabBarController {
            // Set the selected index to the "Biddings" tab (index 1)
            mainTabBarController.selectedIndex = 1
            
            // Optionally, you can scroll to the top of the Biddings page if you need to
            if let navigationController = mainTabBarController.viewControllers?[1] as? UINavigationController,
               let biddingsVC = navigationController.viewControllers.first as? BiddingsViewController {
                biddingsVC.fetchUserBiddings() // Refresh bidded items if necessary
            }
        }
    }
    

    
    // MARK: - Seal the Deal funtionality
    @objc func sealTheDealAction() {
        sealTheDealForItem(documentID: item?.itemId ?? "missing", userId: Auth.auth().currentUser?.email ?? "missing")
        //navigateToBiddingsViewController()
    }
    
    func sealTheDealOnScreen(){
        UIView.animate(withDuration: 0.2, animations: {
            self.BiddingDetailsScreen.sealDealPriceLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.BiddingDetailsScreen.sealDealPriceLabel.transform = CGAffineTransform.identity
            }
        }
        BiddingDetailsScreen.sealDealButton.isEnabled = false
        BiddingDetailsScreen.sealDealButton.setTitle("ALREADY YOURS!", for: .normal)
        
        // navigate to the Biddings screen AFTER sealthedeal is success??
    }
    
    func updateTopBidOnScreen(newBidAmount: Double) {
        // Update the text fields
        BiddingDetailsScreen.topBidPriceLabel.text = String("$\(newBidAmount)")
        BiddingDetailsScreen.newBidTextField.text = ""
        item?.topBid = newBidAmount

        
        UIView.animate(withDuration: 0.2, animations: {
            self.BiddingDetailsScreen.topBidPriceLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.BiddingDetailsScreen.topBidPriceLabel.transform = CGAffineTransform.identity
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
