//
//  BiddingsViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 04/11/24.
//

import UIKit


class BiddingsViewController: UIViewController {
    let tableView = UITableView()
    var biddedItems: [Item] = [
        Item(name: "Item 1", location: "Boston, MA", currentBid: 500, sealPrice: 1200, imageName: "placeholder_image"),
        Item(name: "Item 3", location: "Somerville, MA", currentBid: 250, sealPrice: 700, imageName: "placeholder_image")
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
        // Pass item data to the ItemDescriptionViewController
        navigationController?.pushViewController(itemDescriptionVC, animated: true)
    }
}
