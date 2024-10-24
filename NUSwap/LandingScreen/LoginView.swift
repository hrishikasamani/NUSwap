//
//  LoginView.swift
//  NUSwap
//
//  Created by Dhruv Doshi on 10/24/24.
//

import UIKit

class LoginView: UIView {

    var buttonNavigate: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //MARK: initializing a TableView...
        setupButtonNavigate()
        initConstraints()
    }
    
    func setupButtonNavigate(){
        buttonNavigate = UIButton(type: .system)
        buttonNavigate.isUserInteractionEnabled = true
        buttonNavigate.translatesAutoresizingMaskIntoConstraints = false
        buttonNavigate.setTitle("Navigate", for: .normal)
        self.addSubview(buttonNavigate)
    }
    
    //MARK: setting the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            buttonNavigate.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            buttonNavigate.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            buttonNavigate.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            buttonNavigate.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
