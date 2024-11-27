//
//  HomePageTableViewCell.swift
//  NUSwap
//
//  Created by Preksha Patil on 27/10/24.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {
    let itemImageView = UIImageView()
    let itemNameLabel = UILabel()
    let itemLocationLabel = UILabel()
    let itemPriceLabel = UILabel()
    let itemSealPriceLabel = UILabel()
    let itemDescriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configure image view
        itemImageView.layer.cornerRadius = 8
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.image = UIImage(systemName: "photo") // SF Symbol as a placeholder
        
        // Configure labels
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        itemNameLabel.textAlignment = .center // Center the item name below the image
        itemLocationLabel.font = UIFont.systemFont(ofSize: 14)
        itemLocationLabel.textColor = .gray
        itemPriceLabel.font = UIFont.systemFont(ofSize: 16)
        itemSealPriceLabel.font = UIFont.systemFont(ofSize: 14)
        itemSealPriceLabel.textColor = .gray
        
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        itemDescriptionLabel.textColor = .darkGray
        itemDescriptionLabel.numberOfLines = 2 // Allows multiline description

        // Add subviews to contentView
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemLocationLabel)
        contentView.addSubview(itemPriceLabel)
        contentView.addSubview(itemSealPriceLabel)
        contentView.addSubview(itemDescriptionLabel)

        // Set up layout constraints
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: ItemStruct) {
        itemNameLabel.text = item.name
        itemLocationLabel.text = item.location
        
        // Check if topBid exists, if not use basePrice
        if let topBid = item.topBid {
            itemPriceLabel.text = "$\(topBid)"  // Display topBid if available
        } else {
            itemPriceLabel.text = "$\(item.basePrice)"  // Otherwise, display basePrice
        }
        
        //itemPriceLabel.text = "$\(item.basePrice)" // Use basePrice instead of currentBid
        itemSealPriceLabel.text = "Seal: $\(item.sealTheDealPrice)" // Use sealTheDealPrice instead of sealPrice
        itemDescriptionLabel.text = item.description
        itemImageView.image = UIImage(systemName: "photo") // Placeholder image
    }


    private func setupConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemSealPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Image at the top of the cell
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            itemImageView.heightAnchor.constraint(equalToConstant: 150), // Adjust height as needed

            // Item name below the image
            itemNameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 8),
            itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            // Item location below the name
            itemLocationLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 4),
            itemLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),

            // Price and seal price on the same line
            itemPriceLabel.topAnchor.constraint(equalTo: itemLocationLabel.bottomAnchor, constant: 4),
            itemPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),

            itemSealPriceLabel.centerYAnchor.constraint(equalTo: itemPriceLabel.centerYAnchor),
            itemSealPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            // Item description below the price
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemPriceLabel.bottomAnchor, constant: 4),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            itemDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
