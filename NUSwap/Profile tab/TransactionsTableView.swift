//
//  TransactionsTableView.swift
//  NUSwap
//
//  Created by Karyn T on 12/3/24.
//

import UIKit

class TransactionsTableView: UITableViewCell {
    static let identifier = "TransactionsTableView"

    var itemImageView: UIImageView!
    var itemNameLabel: UILabel!
    var sealedForLabel: UILabel!
    var locationLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupItemImageView()
        setupItemNameLabel()
        setupSealedForLabel()
        setupLocationLabel()
        setupConstraints()
    }

    func setupItemImageView() {
        itemImageView = UIImageView()
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 8
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.image = UIImage(systemName: "photo")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        contentView.addSubview(itemImageView)
    }

    func setupItemNameLabel() {
        itemNameLabel = UILabel()
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(itemNameLabel)
    }

    func setupSealedForLabel() {
        sealedForLabel = UILabel()
        sealedForLabel.font = UIFont.systemFont(ofSize: 14)
        sealedForLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sealedForLabel)
    }

    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .gray
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
    }
    
    func configure(with itemImage: UIImage?, itemName: String, sealedFor: String, isSeller: Bool, location: String) {
        itemImageView.image = itemImage ?? UIImage(systemName: "photo")
        itemNameLabel.text = itemName
        sealedForLabel.text = isSeller ? "Sold for \(sealedFor)" : "Bought for \(sealedFor)"
        locationLabel.text = "Location: \(location)"
        }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemImageView.widthAnchor.constraint(equalToConstant: 60),
            itemImageView.heightAnchor.constraint(equalToConstant: 60),
            
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            sealedForLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 5),
            sealedForLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            sealedForLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            locationLabel.topAnchor.constraint(equalTo: sealedForLabel.bottomAnchor, constant: 5),
            locationLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
