//
//  ItemDescriptionViewViewController.swift
//  NUSwap
//
//  Created by Karyn T on 10/27/24.
//

import UIKit

class ItemDescriptionViewController: UIViewController {
    var itemDescriptionScreen = ItemDescriptionView()
    var item: ItemStruct? // Accept ItemStruct here

    override func loadView() {
        view = itemDescriptionScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        // Update the view with the item details
        if let item = item {
            itemDescriptionScreen.itemNameLabel.text = item.name
            itemDescriptionScreen.itemImage.image = UIImage(systemName: "photo") // Placeholder image
            itemDescriptionScreen.topBidPriceLabel.text = "$\(item.topBid ?? item.basePrice)"
            itemDescriptionScreen.sealDealPriceLabel.text = "$\(item.sealTheDealPrice)"
            itemDescriptionScreen.locationLabel.text = item.location
            itemDescriptionScreen.descriptionDetailsLabel.text = item.description
        }
    }
}
