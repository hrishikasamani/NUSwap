//
//  BiddingsViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 04/11/24.
//

import UIKit

class BiddingsViewController: UIViewController {
    let tableView = UITableView()
    var biddedItems: [ItemStruct] = [
        ItemStruct(name: "Item 1", sellerUserId: "seller1@example.com", category: "Electronics", location: "Boston, MA", description: "Description for item 1", basePrice: 500, sealTheDealPrice: 1200),
        ItemStruct(name: "Item 3", sellerUserId: "seller3@example.com", category: "Furniture", location: "Somerville, MA", description: "Description for item 3", basePrice: 250, sealTheDealPrice: 700)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Biddings"
        view.backgroundColor = .white
        setupTableView()
    }

    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomePageTableViewCell.self, forCellReuseIdentifier: "BiddingCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BiddingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biddedItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BiddingCell", for: indexPath) as! HomePageTableViewCell
        cell.configure(with: biddedItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = biddedItems[indexPath.row]
        let itemDescriptionVC = ItemDescriptionViewController()
        itemDescriptionVC.item = selectedItem
        navigationController?.pushViewController(itemDescriptionVC, animated: true)
    }
}
