//
//  ProfileView.swift
//  WA4_Doshi_6855
//
//  Created by Dhruv Doshi on 10/3/24.
//

import UIKit

class ProfileView: UIView {
    
    var contentWrapper:UIView!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhone: UILabel!
    var toggle: UISegmentedControl!
    var dividerLine: UIView!
    var labelCompletedTransactions: UILabel!
    var labelTransactionDescription: UILabel!
    var dividerLine2: UIView!
    var transactionsTableView: UITableView!
    var emptyListLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupLabelName()
        setupLabelEmail()
        setupLabelPhone()
        setupToggle()
        setupDividerLine()
        setupLabelCompletedTransactions()
        setupLabelTransactionDescription()
        setupDividerLine2()
        setupTransactionsTableView()
        setupEmptyListLabel()
        
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    // MARK: set up UI elements
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.textColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)
        labelName.text = "Hi, NU Swap team"
        contentWrapper.addSubview(labelName)
    }
    
    func setupLabelEmail(){
        labelEmail = UILabel()
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.text = "Email: nuswap.team@northeastern.edu"
        contentWrapper.addSubview(labelEmail)
    }
    
    func setupLabelPhone(){
        labelPhone = UILabel()
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        labelPhone.text = "Phone: 999999999"
        contentWrapper.addSubview(labelPhone)
    }
    
    func setupToggle() {
        toggle = UISegmentedControl(items: ["Light Mode", "Dark Mode"])
        toggle.selectedSegmentIndex = 0 // Default to Light Mode
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.layer.cornerRadius = 16 // Make it look like a switch
        toggle.backgroundColor = UIColor.systemGray5
        toggle.selectedSegmentTintColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)
        toggle.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        toggle.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        contentWrapper.addSubview(toggle)
    }
    
    func setupDividerLine() {
        dividerLine = UIView()
        dividerLine.backgroundColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(dividerLine)
    }
    
    func setupLabelCompletedTransactions() {
        labelCompletedTransactions = UILabel()
        labelCompletedTransactions.text = "Completed Transactions"
        labelCompletedTransactions.font = UIFont.boldSystemFont(ofSize: 23)
        labelCompletedTransactions.textAlignment = .center
        labelCompletedTransactions.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelCompletedTransactions)
    }
    
    func setupLabelTransactionDescription() {
        labelTransactionDescription = UILabel()
        labelTransactionDescription.text = "includes purchases you’ve bought and sold"
        labelTransactionDescription.font = UIFont.systemFont(ofSize: 14)
        labelTransactionDescription.textColor = .gray
        labelTransactionDescription.textAlignment = .center
        labelTransactionDescription.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelTransactionDescription)
    }
    
    func setupDividerLine2() {
        dividerLine2 = UIView()
        dividerLine2.backgroundColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)
        dividerLine2.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(dividerLine2)
    }
    
    func setupTransactionsTableView() {
        transactionsTableView = UITableView()
        transactionsTableView.register(TransactionsTableView.self, forCellReuseIdentifier: TransactionsTableView.identifier)
        transactionsTableView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(transactionsTableView)
    }
    
    func setupEmptyListLabel() {
        emptyListLabel = UILabel()
        emptyListLabel.text = """
                              No transactions recorded yet. 
                              
                              Once you have made a sale or purchase,
                              they will appear here.
                              """
        emptyListLabel.textColor = .gray
        emptyListLabel.textAlignment = .center
        emptyListLabel.font = UIFont.systemFont(ofSize: 14)
        emptyListLabel.isHidden = true
        emptyListLabel.numberOfLines = 0
        emptyListLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyListLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            labelName.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 10),
            labelName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10),
            labelEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 10),
            labelPhone.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            toggle.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 15),
            toggle.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            dividerLine.topAnchor.constraint(equalTo: toggle.bottomAnchor, constant: 20),
            dividerLine.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            dividerLine.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            dividerLine.heightAnchor.constraint(equalToConstant: 2),
            
            labelCompletedTransactions.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 10),
            labelCompletedTransactions.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            labelTransactionDescription.topAnchor.constraint(equalTo: labelCompletedTransactions.bottomAnchor, constant: 3),
            labelTransactionDescription.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            dividerLine2.topAnchor.constraint(equalTo: labelTransactionDescription.bottomAnchor, constant: 10),
            dividerLine2.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            dividerLine2.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            dividerLine2.heightAnchor.constraint(equalToConstant: 2),
            
            transactionsTableView.topAnchor.constraint(equalTo: dividerLine2.bottomAnchor, constant: 10),
            transactionsTableView.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor),
            transactionsTableView.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor),
            transactionsTableView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
            
            emptyListLabel.topAnchor.constraint(equalTo: self.dividerLine2.bottomAnchor, constant: 20),
            emptyListLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            emptyListLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 10),
            emptyListLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -10),
            
            //labelTransactionDescription.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
