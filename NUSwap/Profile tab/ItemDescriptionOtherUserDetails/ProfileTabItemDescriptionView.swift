//
//  ProfileTabItemDescriptionView.swift
//  NUSwap
//
//  Created by Preksha Patil on 07/12/24.
//

import UIKit

class ProfileTabItemDescriptionView: UIView {
    var contentWrapper: UIScrollView!
    var itemNameLabel: UILabel!
    var itemImage: UIImageView!
    var priceLabel: UILabel!
    var locationLabel: UILabel!
    var descriptionLabel: UILabel!
    var buyerSellerDetailsLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupItemNameLabel()
        setupItemImage()
        setupPriceLabel()
        setupLocationLabel()
        setupDescriptionLabel()
        setupBuyerSellerDetailsLabel()
        initConstraints()
    }

    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }

    func setupItemNameLabel() {
        itemNameLabel = UILabel()
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemNameLabel)
    }

    func setupItemImage() {
        itemImage = UIImageView()
        itemImage.contentMode = .scaleAspectFit
        itemImage.layer.cornerRadius = 8
        itemImage.clipsToBounds = true
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemImage)
    }

    func setupPriceLabel() {
        priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 18)
        priceLabel.textColor = .gray
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(priceLabel)
    }

    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.font = UIFont.systemFont(ofSize: 18)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(locationLabel)
    }

    func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(descriptionLabel)
    }
    
    func setupBuyerSellerDetailsLabel() {
        buyerSellerDetailsLabel = UILabel()
        buyerSellerDetailsLabel.font = UIFont.systemFont(ofSize: 18)
        buyerSellerDetailsLabel.numberOfLines = 0
        buyerSellerDetailsLabel.lineBreakMode = .byWordWrapping
        buyerSellerDetailsLabel.textColor = .darkGray
        buyerSellerDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buyerSellerDetailsLabel)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            itemNameLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 20),
            itemNameLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            itemImage.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 20),
            itemImage.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            itemImage.widthAnchor.constraint(equalToConstant: 300),
            itemImage.heightAnchor.constraint(equalToConstant: 250),

            priceLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 20),
            priceLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            locationLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentWrapper.bottomAnchor, constant: -20),
            
            buyerSellerDetailsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            buyerSellerDetailsLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 20),
            buyerSellerDetailsLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -20),
            buyerSellerDetailsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentWrapper.bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
