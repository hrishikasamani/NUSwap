//
//  ListingsTableViewManager.swift
//  NUSwap
//
//  Created by Karyn T on 11/26/24.
//

import Foundation
import UIKit

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
        let listingDetailVC = ListingsDetailViewController()
        listingDetailVC.item = selectedItem
        navigationController?.pushViewController(listingDetailVC, animated: true)
    }
}
