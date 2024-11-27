//
//  HomePageTableViewCell.swift
//  NUSwap
//
//  Created by Preksha Patil on 27/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomePageViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var items: [ItemStruct] = []
    let database = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.prefersLargeTitles = true
        fetchListings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        title = "Home"
        view.backgroundColor = .white
        setupScrollView()
        setupItemsInScrollView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewListing)
        )
        
        fetchListings() // Fetch listings from Firestore
    }
    
    @objc func addNewListing() {
        // Navigate to the Add New Listing screen
        let newListingVC = NewListingViewController()
        navigationController?.pushViewController(newListingVC, animated: true)
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupItemsInScrollView() {
        // Clear existing views
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        var lastView: UIView? = nil
        
        for (index, item) in items.enumerated() {
            let itemView = createItemView(for: item, tag: index)
            contentView.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                itemView.heightAnchor.constraint(equalToConstant: 200)
            ])
            
            if let lastView = lastView {
                itemView.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 16).isActive = true
            } else {
                itemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
            }
            
            lastView = itemView
        }
        
        if let lastView = lastView {
            lastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        }
    }

    func createItemView(for item: ItemStruct, tag: Int) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.tag = tag // Tagging the view to identify the item
        
        let itemNameLabel = UILabel()
        itemNameLabel.text = item.name
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let itemLocationLabel = UILabel()
        itemLocationLabel.text = item.location
        itemLocationLabel.font = UIFont.systemFont(ofSize: 14)
        itemLocationLabel.textColor = .black
        
        let itemPriceLabel = UILabel()
        itemPriceLabel.text = "Top bid: $\(item.topBid ?? 0)"
        itemPriceLabel.font = UIFont.systemFont(ofSize: 16)
        
        let itemSealPriceLabel = UILabel()
        itemSealPriceLabel.text = "Seal: $\(item.sealTheDealPrice)"
        itemSealPriceLabel.font = UIFont.systemFont(ofSize: 14)
        itemSealPriceLabel.textColor = .black
        
        let itemDescriptionLabel = UILabel()
        itemDescriptionLabel.text = item.description
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        itemDescriptionLabel.numberOfLines = 2 // Truncate long descriptions
        
        containerView.addSubview(itemNameLabel)
        containerView.addSubview(itemLocationLabel)
        containerView.addSubview(itemPriceLabel)
        containerView.addSubview(itemSealPriceLabel)
        containerView.addSubview(itemDescriptionLabel)
        
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemSealPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            itemNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            itemNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            itemLocationLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 4),
            itemLocationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            itemPriceLabel.topAnchor.constraint(equalTo: itemLocationLabel.bottomAnchor, constant: 4),
            itemPriceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            itemSealPriceLabel.centerYAnchor.constraint(equalTo: itemPriceLabel.centerYAnchor),
            itemSealPriceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemPriceLabel.bottomAnchor, constant: 4),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            itemDescriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
        containerView.addGestureRecognizer(tapGesture)
        
        return containerView
    }

    @objc func itemTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        let selectedItem = items[tag]
        
        let biddingDetailsVC = BiddingsDetailViewController()
        biddingDetailsVC.item = selectedItem // Pass the selected item
        navigationController?.pushViewController(biddingDetailsVC, animated: true)
    }

    func fetchListings() {
            guard let currentUserEmail = Auth.auth().currentUser?.email else {
                print("User not found")
                return
            }

            database.collection("items").getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching listings: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No listings found")
                    return
                }

                self.items = documents.compactMap { document in
                    let data = document.data()
                    let itemId = document.documentID
                    
                    // Exclude listings created by the current user and listings with a non-nil buyerUserId
                    guard let sellerUserId = data["sellerUserId"] as? String,
                          sellerUserId != currentUserEmail,
                          let name = data["name"] as? String,
                          let category = data["category"] as? String,
                          let location = data["location"] as? String,
                          let description = data["description"] as? String,
                          let basePrice = data["basePrice"] as? Double,
                          let sealTheDealPrice = data["sealTheDealPrice"] as? Double,
                          data["buyerUserId"] == nil else {
                        return nil
                    }
                    
                    let topBid = (data["topBid"] as? Double) ?? basePrice
                    
                    return ItemStruct(
                        itemId: itemId,
                        name: name,
                        sellerUserId: sellerUserId,
                        buyerUserId: nil,
                        category: category,
                        location: location,
                        description: description,
                        basePrice: basePrice,
                        sealTheDealPrice: sealTheDealPrice,
                        topBid: topBid
                    )
                }

                DispatchQueue.main.async {
                    self.setupItemsInScrollView()
                }
            }
        }



}
