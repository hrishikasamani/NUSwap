//
//  ProfileTabItemDescriptionViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 07/12/24.
//

import UIKit

class ProfileTabItemDescriptionViewController: UIViewController {
    var profileTabItemDescriptionView = ProfileTabItemDescriptionView()
    var transaction: ItemStruct? // Transaction to display

    override func loadView() {
        view = profileTabItemDescriptionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        ThemeManager.applyDefaultTheme(to: profileTabItemDescriptionView)
        self.navigationController?.navigationBar.tintColor = UIColor.label
        
        // Populate data into the view
        if let transaction = transaction {
            profileTabItemDescriptionView.itemNameLabel.text = transaction.name
            profileTabItemDescriptionView.priceLabel.text = "Price: \(transaction.topBidPrice ?? transaction.sealTheDealPrice)"
            profileTabItemDescriptionView.locationLabel.text = "Location: \(transaction.location)"
            profileTabItemDescriptionView.descriptionLabel.text = transaction.description

            if let imageUrlString = transaction.imageURL, let imageUrl = URL(string: imageUrlString) {
                URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                    if let data = data, let fetchedImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.profileTabItemDescriptionView.itemImage.image = fetchedImage
                        }
                    }
                }.resume()
            }
        }
        // Fetch and display buyer/seller details
        fetchBuyerOrSellerDetails()
    }
}

