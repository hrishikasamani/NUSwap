//
//  LoginView.swift
//  App10
//
//  Created by Dhruv Doshi on 10/27/24.
//

import UIKit

class LoginView: UIView {

    // MARK: Initialize variables
    var contentWrapper:UIScrollView!
    var imageLogo: UIImageView!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!
    var buttonJumpToItemDesc: UIButton!
    var addListing: UIButton!
    var buttonNavigate: UIButton!
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupImageLogo()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonLogin()
        setupButtonRegister()
        initConstraints()
    }
    
    // MARK: set up UI elements
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    func setupImageLogo() {
        imageLogo = UIImageView()
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.image = UIImage(named: "nuswaplogo")
        imageLogo.contentMode = .scaleAspectFit
        contentWrapper.addSubview(imageLogo)
        }
    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Northeastern Email"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.textAlignment = .left
        textFieldEmail.keyboardType = .emailAddress
        contentWrapper.addSubview(textFieldEmail)
    }
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.textAlignment = .left
        textFieldPassword.isSecureTextEntry = true // Default to secure entry
        textFieldPassword.textContentType = .oneTimeCode // Disable autofill
        textFieldPassword.passwordRules = nil // Remove password suggestions

        // Add an eye icon toggle button
        let toggleButton = UIButton(type: .system)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        toggleButton.tintColor = .gray
        toggleButton.addTarget(self, action: #selector(toggleLoginPasswordVisibility(_:)), for: .touchUpInside)

        textFieldPassword.rightView = toggleButton
        textFieldPassword.rightViewMode = .always

        contentWrapper.addSubview(textFieldPassword)
    }

    @objc func toggleLoginPasswordVisibility(_ sender: UIButton) {
        textFieldPassword.isSecureTextEntry.toggle()
        let imageName = textFieldPassword.isSecureTextEntry ? "eye" : "eye.slash"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }

    func setupButtonLogin(){
        buttonLogin = UIButton(type: .system)
        buttonLogin.isUserInteractionEnabled = true
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.setTitle("Login", for: .normal)
        
        // Style
        buttonLogin.backgroundColor = UIColor.systemBlue
        buttonLogin.setTitleColor(.white, for: .normal)
        buttonLogin.layer.cornerRadius = 8
        buttonLogin.layer.masksToBounds = true
        buttonLogin.backgroundColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)  // Color: #BF0000

        contentWrapper.addSubview(buttonLogin)
    }
    func setupButtonRegister(){
        buttonRegister = UIButton(type: .system)
        buttonRegister.isUserInteractionEnabled = true
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.setTitleColor(UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1), for: .normal)
        contentWrapper.addSubview(buttonRegister)
    }
    
    
    //MARK: initializing constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            imageLogo.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 32),
            imageLogo.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            imageLogo.widthAnchor.constraint(equalToConstant: 100),
            imageLogo.heightAnchor.constraint(equalToConstant: 100),
            
            textFieldEmail.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 32),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant: 16),
            textFieldEmail.trailingAnchor.constraint(equalTo:contentWrapper.trailingAnchor, constant: -16),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant:16),
            textFieldPassword.trailingAnchor.constraint(equalTo:contentWrapper.trailingAnchor,
            constant: -16),
            
            
            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            buttonLogin.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonLogin.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant: 16),
            buttonLogin.trailingAnchor.constraint(equalTo:contentWrapper.trailingAnchor,
            constant: -16),
            
            buttonRegister.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 16),
            buttonRegister.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonRegister.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant: 16),
            buttonRegister.trailingAnchor.constraint(equalTo:contentWrapper.trailingAnchor,
            constant: -16),
        ])
        contentWrapper.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    func configureTitleAppearance(navigationController: UINavigationController?) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)
            ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
