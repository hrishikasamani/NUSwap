//
//  ProfileView.swift
//  WA4_Doshi_6855
//
//  Created by Dhruv Doshi on 10/3/24.
//

import UIKit

class ProfileView: UIView {
    
    var contentWrapper:UIScrollView!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhone: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupLabelName()
        setupLabelEmail()
        setupLabelPhone()
        initConstraints()
    }
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    // MARK: set up UI elements
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 25)
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
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            //MARK: contentWrapper constraints...
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            // labelName constraints
            labelName.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 32),
            labelName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            labelName.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),

            
            // labelEmail constraints
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            labelEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            labelEmail.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            
            // labelEmail constraints
            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            labelPhone.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            labelPhone.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
