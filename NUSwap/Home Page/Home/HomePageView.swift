//
//  HomePageView.swift
//  NUSwap
//
//  Created by Karyn T on 11/30/24.
//

import UIKit

class HomePageView: UIView {
    var tableViewHome: UITableView!
    var emptyListLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupTableView()
        setupEmptyListLabel()
        
        initConstraints()
    }
    
    func setupTableView() {
        tableViewHome = UITableView()
        tableViewHome.register(HomePageTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        tableViewHome.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewHome)
    }
    
    func setupEmptyListLabel() {
        emptyListLabel = UILabel()
        emptyListLabel.text = """
                              Welcome to the marketplace!
                              
                              No listings here yet.
                              
                              Please check back later.
                              """
        emptyListLabel.textColor = .gray
        emptyListLabel.textAlignment = .center
        emptyListLabel.font = UIFont.systemFont(ofSize: 20)
        emptyListLabel.isHidden = true
        emptyListLabel.numberOfLines = 0
        emptyListLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyListLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewHome.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableViewHome.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableViewHome.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableViewHome.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            emptyListLabel.topAnchor.constraint(equalTo: self.tableViewHome.topAnchor, constant: 100),
            emptyListLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emptyListLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            emptyListLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
