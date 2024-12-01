//
//  HomePageTableViewCell.swift
//  NUSwap
//
//  Created by Preksha Patil on 27/10/24.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {
    
    var itemImageView: UIImageView!
    var itemNameLabel: UILabel!
    var itemLocationLabel: UILabel!
    var itemPriceLabel: UILabel!
    var itemSealPriceLabel: UILabel!
    var itemDescriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupItemImageView()
        setupItemNameLabel()
        setupItemLocationLabel()
        setupItemPriceLabel()
        setupItemSealPriceLabel()
        setupItemDescriptionLabel()
        setupConstraints()
    }
    
    // MARK: Setup UI Elements
    func setupItemImageView() {
        itemImageView = UIImageView()
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.layer.cornerRadius = 8
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.image = UIImage(systemName: "photo") // Placeholder image
        contentView.addSubview(itemImageView)
    }
    
    func setupItemNameLabel() {
        itemNameLabel = UILabel()
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        itemNameLabel.textAlignment = .center
        contentView.addSubview(itemNameLabel)
    }
    
    func setupItemLocationLabel() {
        itemLocationLabel = UILabel()
        itemLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLocationLabel.font = UIFont.systemFont(ofSize: 14)
        itemLocationLabel.textColor = .gray
        contentView.addSubview(itemLocationLabel)
    }
    
    func setupItemPriceLabel() {
        itemPriceLabel = UILabel()
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(itemPriceLabel)
    }
    
    func setupItemSealPriceLabel() {
        itemSealPriceLabel = UILabel()
        itemSealPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemSealPriceLabel.font = UIFont.systemFont(ofSize: 14)
        itemSealPriceLabel.textColor = .gray
        contentView.addSubview(itemSealPriceLabel)
    }
    
    func setupItemDescriptionLabel() {
        itemDescriptionLabel = UILabel()
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        itemDescriptionLabel.textColor = .darkGray
        itemDescriptionLabel.numberOfLines = 2
        contentView.addSubview(itemDescriptionLabel)
    }
    
    // MARK: Configure Cell with Data
    func configure(with item: ItemStruct) {
        itemNameLabel.text = item.name
        itemLocationLabel.text = item.location
        itemPriceLabel.text = "Base Price: $\(item.basePrice)"
        itemSealPriceLabel.text = "Seal: $\(item.sealTheDealPrice)"
        itemDescriptionLabel.text = item.description
        itemImageView.image = UIImage(systemName: "photo") // Placeholder image
    }
    
    // MARK: Setup Constraints
    func setupConstraints() {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
