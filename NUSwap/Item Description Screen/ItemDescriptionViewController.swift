//
//  ItemDescriptionViewViewController.swift
//  NUSwap
//
//  Created by Karyn T on 10/27/24.
//

import UIKit

class ItemDescriptionViewController: UIViewController {
    var itemDescriptionScreen = ItemDescriptionView()
    var item: Item? // Add this property to receive the selected item

    override func loadView() {
        view = itemDescriptionScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            //hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .white

        // Update the view with the item details
        if let item = item {
            itemDescriptionScreen.itemNameLabel.text = item.name
            itemDescriptionScreen.itemImage.image = UIImage(systemName: "photo") // Placeholder image
            itemDescriptionScreen.topBidPriceLabel.text = "$\(item.currentBid)"
            itemDescriptionScreen.sealDealPriceLabel.text = "$\(item.sealPrice)"
            itemDescriptionScreen.locationLabel.text = item.location
            itemDescriptionScreen.descriptionDetailsLabel.text = "Description for \(item.name)"
        }
    }
}
