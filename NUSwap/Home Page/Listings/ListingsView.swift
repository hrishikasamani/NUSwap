//
//  ListingsView.swift
//  NUSwap
//
//  Created by Karyn T on 11/26/24.
//

import UIKit

class ListingsView: UIView {
    var tableViewListings: UITableView!
    var emptyListLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupTableView()
        setupEmptyListLabel()
        
        initConstraints()
    }
    
    func setupTableView() {
        tableViewListings = UITableView()
        tableViewListings.register(HomePageTableViewCell.self, forCellReuseIdentifier: "ListingCell")
        tableViewListings.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewListings)
    }
    
    func setupEmptyListLabel() {
        emptyListLabel = UILabel()
        emptyListLabel.text = """
                                Your listings will appear here.
                                
                                Tap ‘+’ to get started.
                                """
        emptyListLabel.textColor = .gray
        emptyListLabel.textAlignment = .center
        emptyListLabel.font = UIFont.systemFont(ofSize: 20)
        emptyListLabel.numberOfLines = 0
        emptyListLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(emptyListLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewListings.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableViewListings.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableViewListings.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableViewListings.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            emptyListLabel.topAnchor.constraint(equalTo: self.tableViewListings.topAnchor, constant: 100),
            emptyListLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emptyListLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            emptyListLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
