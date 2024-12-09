//
//  BiddingsView.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/27/24.
//

import UIKit

class BiddingsView: UIView {
    var tableViewBiddings: UITableView!
    var emptyListLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupTableView()
        setupEmptyListLabel()
        initConstraints()
    }
    
    func setupTableView() {
        tableViewBiddings = UITableView()
        tableViewBiddings.register(HomePageTableViewCell.self, forCellReuseIdentifier: "BiddingCell")
        tableViewBiddings.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewBiddings)
    }
    
    func setupEmptyListLabel() {
        emptyListLabel = UILabel()
        emptyListLabel.text = """
                                Once you place a bid on an item,
                                
                                your bidding will appear here.
                                
                                Tap ‘Home’ to get started with bidding.
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
            tableViewBiddings.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableViewBiddings.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableViewBiddings.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableViewBiddings.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            emptyListLabel.topAnchor.constraint(equalTo: self.tableViewBiddings.topAnchor, constant: 100),
            emptyListLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emptyListLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            emptyListLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
