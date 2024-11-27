//
//  BiddingsTableViewManager.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/27/24.
//

import UIKit

import Foundation
import UIKit

extension BiddingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biddedItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BiddingCell", for: indexPath) as! HomePageTableViewCell
        let item = biddedItems[indexPath.row]
        cell.configure(with: biddedItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = biddedItems[indexPath.row]
        let biddingDetailVC = BiddingsDetailViewController()
        biddingDetailVC.item = selectedItem
        navigationController?.pushViewController(biddingDetailVC, animated: true)
    }
}
