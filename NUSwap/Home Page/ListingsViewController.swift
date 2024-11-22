//
//  ListingsViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 04/11/24.
//

import UIKit

class ListingsViewController: UIViewController {
    let tableView = UITableView()
    var listedItems: [Item] = [
        Item(name: "Item 4", location: "Brookline, MA", currentBid: 600, sealPrice: 1500, imageName: "placeholder_image"),
        Item(name: "Item 5", location: "Quincy, MA", currentBid: 450, sealPrice: 1000, imageName: "placeholder_image")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Listings"
        view.backgroundColor = .white
        setupTableView()
    }

    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: "ListingCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listedItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! HomePageTableViewCell
        cell.configure(with: listedItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = listedItems[indexPath.row]
        let itemDescriptionVC = ItemDescriptionViewController()
        // Pass item data to the ItemDescriptionViewController
        navigationController?.pushViewController(itemDescriptionVC, animated: true)
    }
}
