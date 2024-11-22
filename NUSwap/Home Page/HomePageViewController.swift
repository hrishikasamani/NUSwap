//
//  HomePageTableViewCell.swift
//  NUSwap
//
//  Created by Preksha Patil on 27/10/24.
//



import UIKit

class HomePageViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    var items: [Item] = [
        Item(name: "Item 1", location: "Boston, MA", currentBid: 500, sealPrice: 1200, imageName: "placeholder_image"),
        Item(name: "Item 2", location: "Cambridge, MA", currentBid: 300, sealPrice: 900, imageName: "placeholder_image"),
        Item(name: "Item 3", location: "Somerville, MA", currentBid: 250, sealPrice: 700, imageName: "placeholder_image"),
        Item(name: "Item 4", location: "Brookline, MA", currentBid: 600, sealPrice: 1500, imageName: "placeholder_image"),
        Item(name: "Item 5", location: "Quincy, MA", currentBid: 450, sealPrice: 1000, imageName: "placeholder_image"),
                Item(name: "Item 6", location: "Newton, MA", currentBid: 350, sealPrice: 800, imageName: "placeholder_image"),
                Item(name: "Item 7", location: "Medford, MA", currentBid: 700, sealPrice: 1600, imageName: "placeholder_image"),
               Item(name: "Item 8", location: "Malden, MA", currentBid: 400, sealPrice: 1100, imageName: "placeholder_image"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .white

        // Add navigation bar button for adding new listings
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewListing)
        )

        // Set up scroll view and items
        setupScrollView()
        setupItemsInScrollView()
    }

    @objc func addNewListing() {
        // Navigate to NewListingViewController
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
        var lastView: UIView? = nil
        
        for (index, item) in items.enumerated() {
            let itemView = createItemView(for: item)
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

    func createItemView(for item: Item) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.isUserInteractionEnabled = true // Enable interaction for the view

        let imageView = UIImageView()
        if let image = UIImage(named: item.imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "photo") // Use SF Symbol as a placeholder
            imageView.tintColor = .black // Optional: Set a color for the SF Symbol placeholder
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        let itemNameLabel = UILabel()
        itemNameLabel.text = item.name
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 16)

        let itemLocationLabel = UILabel()
        itemLocationLabel.text = item.location
        itemLocationLabel.font = UIFont.systemFont(ofSize: 14)
        itemLocationLabel.textColor = .black

        let itemPriceLabel = UILabel()
        itemPriceLabel.text = "$\(item.currentBid)"
        itemPriceLabel.font = UIFont.systemFont(ofSize: 16)

        let itemSealPriceLabel = UILabel()
        itemSealPriceLabel.text = "(\(item.sealPrice))"
        itemSealPriceLabel.font = UIFont.systemFont(ofSize: 14)
        itemSealPriceLabel.textColor = .black

        // Add subviews
        containerView.addSubview(imageView)
        containerView.addSubview(itemNameLabel)
        containerView.addSubview(itemLocationLabel)
        containerView.addSubview(itemPriceLabel)
        containerView.addSubview(itemSealPriceLabel)

        // Set up layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemSealPriceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),

            itemNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            itemNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            itemNameLabel.bottomAnchor.constraint(equalTo: itemLocationLabel.topAnchor, constant: -4),

            itemLocationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            itemLocationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            itemLocationLabel.bottomAnchor.constraint(equalTo: itemPriceLabel.topAnchor, constant: -4),

            itemPriceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            itemPriceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),

            itemSealPriceLabel.centerYAnchor.constraint(equalTo: itemPriceLabel.centerYAnchor),
            itemSealPriceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])

        // Add Tap Gesture Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleItemTap(_:)))
        containerView.addGestureRecognizer(tapGesture)
        containerView.tag = items.firstIndex(where: { $0.name == item.name }) ?? -1 // Store index for identification

        return containerView
    }
    @objc func handleItemTap(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        let index = tappedView.tag
        guard index >= 0 && index < items.count else { return }

        // Get the selected item
        let selectedItem = items[index]

        // Navigate to the Item Description Page
        let itemDescriptionVC = ItemDescriptionViewController()
        itemDescriptionVC.item = selectedItem
        navigationController?.pushViewController(itemDescriptionVC, animated: true)
    }

}
