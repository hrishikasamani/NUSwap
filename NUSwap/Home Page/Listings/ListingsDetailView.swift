//
//  ListingsDetailView.swift
//  NUSwap
//
//  Created by Karyn T on 11/26/24.
//

import UIKit

class ListingsDetailView: UIView {
    
    // section 1: title & image
    var contentWrapper: UIScrollView!
    var itemNameLabel: UILabel!
    var itemImage: UIImageView!
    
    // section 2: top bid & seal the deal price
    var bidsVerticalDivider: UIView!
    var topBidLabel: UILabel!
    var topBidPriceLabel: UILabel!
    var topBidStackView: UIStackView!
    var topBidContainer: UIView!
    var sealDealLabel: UILabel!
    var sealDealPriceLabel: UILabel!
    var sealDealStackView: UIStackView!
    var sealDealContainer: UIView!
    
    // section 3: location
    var locationDivider: UIView!
    var locationImage: UIImageView!
    var locationLabel: UILabel!
    
    // section 4: description
    var descriptionDivider: UIView!
    var descriptionLabel: UILabel!
    var descriptionDetailsLabel: UILabel!
    var descriptionScrollView: UIScrollView!
    
    // section 5: sell to top bidder & delete listing
    var bidsHorizontalDivider: UIView!
    var sellToTopBidButton: UIButton!
    var deleteListingButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupItemNameLabel()
        setupItemImage()
        
        setupBidSection()
        
        setupLocationDivider()
        setupLocationImage()
        setupLocationLabel()
        
        setupDescriptionDivider()
        setupDescriptionLabel()
        setupDescriptionDetailsLabel()
        
        setupBidsHorizontalDivider()
        setupSellToTopBidButton()
        setupDeleteListingButton()
        
        initConstraints()
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupItemNameLabel() {
        itemNameLabel = UILabel()
        itemNameLabel.text = "Beautiful vintage lamp"
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemNameLabel)
    }
    
    func setupItemImage() {
        itemImage = UIImageView()
        itemImage.image = UIImage(systemName: "camera.fill")
        itemImage.contentMode = .scaleAspectFit
        itemImage.clipsToBounds = true
        itemImage.layer.cornerRadius = 10
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(itemImage)
    }
    
    func setupBidSection() {
        topBidLabel = UILabel()
        topBidLabel.text = "Top Bid"
        topBidLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        topBidPriceLabel = UILabel()
        topBidPriceLabel.text = "$20"
        topBidPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        sealDealLabel = UILabel()
        sealDealLabel.text = "Seal the Deal"
        sealDealLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        sealDealPriceLabel = UILabel()
        sealDealPriceLabel.text = "$150"
        sealDealPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        topBidStackView = UIStackView(arrangedSubviews: [topBidLabel, topBidPriceLabel])
        topBidStackView.axis = .vertical
        topBidStackView.alignment = .center
        topBidStackView.spacing = 5
        topBidStackView.translatesAutoresizingMaskIntoConstraints = false
        
        sealDealStackView = UIStackView(arrangedSubviews: [sealDealLabel, sealDealPriceLabel])
        sealDealStackView.axis = .vertical
        sealDealStackView.alignment = .center
        sealDealStackView.spacing = 5
        sealDealStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bidsVerticalDivider = UIView()
        bidsVerticalDivider.backgroundColor = .lightGray
        bidsVerticalDivider.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(bidsVerticalDivider)
        
        topBidContainer = UIView()
        topBidContainer.translatesAutoresizingMaskIntoConstraints = false
        topBidContainer.addSubview(topBidStackView)
        contentWrapper.addSubview(topBidContainer)
        
        sealDealContainer = UIView()
        sealDealContainer.translatesAutoresizingMaskIntoConstraints = false
        sealDealContainer.addSubview(sealDealStackView)
        contentWrapper.addSubview(sealDealContainer)
    }
    
    func setupLocationDivider() {
        locationDivider = UIView()
        locationDivider.backgroundColor = .lightGray
        locationDivider.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(locationDivider)
    }
    
    func setupLocationImage() {
        locationImage = UIImageView()
        locationImage.image = UIImage(systemName: "mappin.and.ellipse")
        locationImage.tintColor = .black
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(locationImage)
    }
    
    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.text = "Boston, MA"
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.textAlignment = .left
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(locationLabel)
    }
    
    func setupDescriptionDivider() {
        descriptionDivider = UIView()
        descriptionDivider.backgroundColor = .lightGray
        descriptionDivider.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(descriptionDivider)
    }
    
    func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descriptionLabel.textAlignment = .left
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(descriptionLabel)
    }
    
    func setupDescriptionDetailsLabel() {
        // allows details label to be scrollable
        descriptionScrollView = UIScrollView()
        descriptionScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(descriptionScrollView)
        
        descriptionDetailsLabel = UILabel()
        descriptionDetailsLabel.text = """
                                        - 80s vibes
                                        - Perfect for cozy spaces
                                        - Gives off warm, soft glow
                                        - Ideal for reading, relaxing or setting the mood for a quiet evening
                                        - Great centerpiece of any living room, bedroom or study
                                        - Add a touch of nostalgia with its aesthetic
                                        """
        descriptionDetailsLabel.numberOfLines = 0
        descriptionDetailsLabel.lineBreakMode = .byWordWrapping
        descriptionDetailsLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionScrollView.addSubview(descriptionDetailsLabel)

    }
    
    func setupBidsHorizontalDivider() {
        bidsHorizontalDivider = UIView()
        bidsHorizontalDivider.backgroundColor = .lightGray
        bidsHorizontalDivider.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(bidsHorizontalDivider)
    }
    
    func setupSellToTopBidButton() {
        sellToTopBidButton = UIButton(type: .system)
        sellToTopBidButton.setTitle("Sell to top bidder now", for: .normal)
        sellToTopBidButton.backgroundColor = UIColor(red: 0/255, green: 153/255, blue: 0/255, alpha: 1)
        sellToTopBidButton.setTitleColor(.white, for: .normal)
        sellToTopBidButton.layer.cornerRadius = 8
        sellToTopBidButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(sellToTopBidButton)
    }
    
    func setupDeleteListingButton() {
        deleteListingButton = UIButton(type: .system)
        deleteListingButton.setTitle("Delete listing", for: .normal)
        deleteListingButton.backgroundColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)
        deleteListingButton.setTitleColor(.white, for: .normal)
        deleteListingButton.layer.cornerRadius = 8
        deleteListingButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(deleteListingButton)
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
            itemImage.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 20),
            itemImage.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -20),
            itemImage.widthAnchor.constraint(equalToConstant: 300),
            itemImage.heightAnchor.constraint(equalToConstant: 250),
            
            bidsVerticalDivider.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            bidsVerticalDivider.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 16),
            bidsVerticalDivider.heightAnchor.constraint(equalToConstant: 40),
            bidsVerticalDivider.widthAnchor.constraint(equalToConstant: 1),
            
            topBidStackView.centerXAnchor.constraint(equalTo: topBidContainer.centerXAnchor),
            topBidStackView.centerYAnchor.constraint(equalTo: topBidContainer.centerYAnchor),
            
            topBidContainer.trailingAnchor.constraint(equalTo: bidsVerticalDivider.leadingAnchor, constant: -100),
            topBidContainer.centerYAnchor.constraint(equalTo: bidsVerticalDivider.centerYAnchor),
            
            sealDealStackView.centerXAnchor.constraint(equalTo: sealDealContainer.centerXAnchor),
            sealDealStackView.centerYAnchor.constraint(equalTo: sealDealContainer.centerYAnchor),

            sealDealContainer.leadingAnchor.constraint(equalTo: bidsVerticalDivider.trailingAnchor, constant: 100),
            sealDealContainer.centerYAnchor.constraint(equalTo: bidsVerticalDivider.centerYAnchor),
            
            locationDivider.topAnchor.constraint(equalTo: topBidContainer.bottomAnchor, constant: 40),
            locationDivider.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 10),
            locationDivider.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -10),
            locationDivider.heightAnchor.constraint(equalToConstant: 1),
            
            locationImage.topAnchor.constraint(equalTo: locationDivider.bottomAnchor, constant: 20),
            locationImage.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 20),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 8),
            
            descriptionDivider.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            descriptionDivider.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 10),
            descriptionDivider.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -10),
            descriptionDivider.heightAnchor.constraint(equalToConstant: 1),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionDivider.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 20),
            
            descriptionScrollView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionScrollView.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 20),
            descriptionScrollView.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -20),
            descriptionScrollView.heightAnchor.constraint(equalToConstant: 100),

            descriptionDetailsLabel.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor),
            descriptionDetailsLabel.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor),
            descriptionDetailsLabel.trailingAnchor.constraint(equalTo: descriptionScrollView.trailingAnchor),
            descriptionDetailsLabel.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor),
            descriptionDetailsLabel.widthAnchor.constraint(equalTo: descriptionScrollView.widthAnchor),
            
            bidsHorizontalDivider.topAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor, constant: 20),
            bidsHorizontalDivider.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 10),
            bidsHorizontalDivider.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -10),
            bidsHorizontalDivider.heightAnchor.constraint(equalToConstant: 1),
            
            sellToTopBidButton.heightAnchor.constraint(equalToConstant: 40),
            
            sellToTopBidButton.topAnchor.constraint(equalTo:bidsHorizontalDivider.bottomAnchor, constant: 20),
            sellToTopBidButton.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 80),
            sellToTopBidButton.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -80),
            
            deleteListingButton.topAnchor.constraint(equalTo: sellToTopBidButton.bottomAnchor, constant: 15),
            deleteListingButton.leadingAnchor.constraint(equalTo: sellToTopBidButton.leadingAnchor),
            deleteListingButton.trailingAnchor.constraint(equalTo: sellToTopBidButton.trailingAnchor),
            deleteListingButton.heightAnchor.constraint(equalTo: sellToTopBidButton.heightAnchor),
            
            deleteListingButton.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
