//
//  ListingsView.swift
//  NUSwap
//
//  Created by Karyn T on 11/26/24.
//

import UIKit

class ListingsView: UIView {
    var tableViewListings: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupTableView()
        initConstraints()
    }
    
    func setupTableView() {
        tableViewListings = UITableView()
        tableViewListings.register(HomePageTableViewCell.self, forCellReuseIdentifier: "ListingCell")
        tableViewListings.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewListings)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewListings.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableViewListings.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableViewListings.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableViewListings.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
