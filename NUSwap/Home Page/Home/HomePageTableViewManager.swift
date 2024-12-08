//
//  HomePageTableViewManager.swift
//  NUSwap
//
//  Created by Preksha Patil on 30/11/24.
//

import UIKit

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < items.count else {
            return UITableViewCell() // Return an empty cell if the index is out of bounds
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomePageTableViewCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        let itemDescriptionVC = ItemDescriptionViewController()
        itemDescriptionVC.item = selectedItem
        navigationController?.pushViewController(itemDescriptionVC, animated: true)
    }
}
