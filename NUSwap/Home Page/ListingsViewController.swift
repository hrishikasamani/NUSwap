//
//  ListingsViewController.swift
//  NUSwap
//
//  Created by Preksha Patil on 04/11/24.
//

import UIKit
import FirebaseAuth

class ListingsViewController: UIViewController {
    let tableView = UITableView()
    var listedItems: [ItemStruct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Listings"
        view.backgroundColor = .white
        setupTableView()
        fetchUserListings()
        
        // Observe new listing notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewListingNotification(_:)), name: NSNotification.Name("NewListingAdded"), object: nil)
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

    @objc func fetchUserListings() {
        guard let currentUser = Auth.auth().currentUser else {
            print("User not logged in")
            return
        }

        FirebaseItemCommands.fetchUserListings(userEmail: currentUser.email ?? "") { result in
            switch result {
            case .success(let items):
                self.listedItems = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch user listings: \(error.localizedDescription)")
            }
        }
    }

    @objc func handleNewListingNotification(_ notification: Notification) {
        if let newItem = notification.object as? ItemStruct {
            // Append the new item at the bottom of the list
            self.listedItems.append(newItem)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        itemDescriptionVC.item = selectedItem
        navigationController?.pushViewController(itemDescriptionVC, animated: true)
    }
}
