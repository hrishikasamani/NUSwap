//
//  RegisterView.swift
//  App10
//
//  Created by Dhruv Doshi on 10/27/24.
//

import UIKit

class RegisterView: UIView {

    // MARK: Initialize variables
    var contentWrapper:UIScrollView!
    var imageLogo: UIImageView!
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPhone: UITextField!
    var textFieldPassword: UITextField!
    var textFieldVerifyPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupImageLogo()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPhone()
        setupTextFieldPassword()
        setupTextFieldVerifyPassword()
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
    func setupTextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.borderStyle = .roundedRect
        textFieldName.textAlignment = .left
        contentWrapper.addSubview(textFieldName)
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
    func setupTextFieldPhone(){
        textFieldPhone = UITextField()
        textFieldPhone.placeholder = "Phone number"
        textFieldPhone.translatesAutoresizingMaskIntoConstraints = false
        textFieldPhone.borderStyle = .roundedRect
        textFieldPhone.textAlignment = .left
        textFieldPhone.keyboardType = .phonePad
        contentWrapper.addSubview(textFieldPhone)
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
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)

        textFieldPassword.rightView = toggleButton
        textFieldPassword.rightViewMode = .always

        contentWrapper.addSubview(textFieldPassword)
    }

    func setupTextFieldVerifyPassword() {
        textFieldVerifyPassword = UITextField()
        textFieldVerifyPassword.placeholder = "Verify Password"
        textFieldVerifyPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldVerifyPassword.borderStyle = .roundedRect
        textFieldVerifyPassword.textAlignment = .left
        textFieldVerifyPassword.isSecureTextEntry = true // Default to secure entry
        textFieldVerifyPassword.textContentType = .oneTimeCode // Disable autofill
        textFieldVerifyPassword.passwordRules = nil // Remove password suggestions

        // Add an eye icon toggle button
        let toggleButton = UIButton(type: .system)
        toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        toggleButton.tintColor = .gray
        toggleButton.addTarget(self, action: #selector(toggleVerifyPasswordVisibility(_:)), for: .touchUpInside)

        textFieldVerifyPassword.rightView = toggleButton
        textFieldVerifyPassword.rightViewMode = .always

        contentWrapper.addSubview(textFieldVerifyPassword)
    }

    @objc func togglePasswordVisibility(_ sender: UIButton) {
        textFieldPassword.isSecureTextEntry.toggle()
        let imageName = textFieldPassword.isSecureTextEntry ? "eye" : "eye.slash"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @objc func toggleVerifyPasswordVisibility(_ sender: UIButton) {
        textFieldVerifyPassword.isSecureTextEntry.toggle()
        let imageName = textFieldVerifyPassword.isSecureTextEntry ? "eye" : "eye.slash"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }



    func setupButtonLogin(){
        buttonLogin = UIButton(type: .system)
        buttonLogin.isUserInteractionEnabled = true
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.setTitleColor(UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1), for: .normal)
        contentWrapper.addSubview(buttonLogin)
    }
    func setupButtonRegister(){
        buttonRegister = UIButton(type: .system)
        buttonRegister.isUserInteractionEnabled = true
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        buttonRegister.setTitle("Register", for: .normal)
        
        // Style
        buttonRegister.backgroundColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)  // Color: #BF0000
        buttonRegister.setTitleColor(.white, for: .normal)
        buttonRegister.layer.cornerRadius = 8
        buttonRegister.layer.masksToBounds = true
        
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
            
            textFieldName.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 32),
            textFieldName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldName.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant:
            16),
            textFieldName.trailingAnchor.constraint(equalTo:
                                                        contentWrapper.trailingAnchor,
            constant: -16),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant:
            16),
            textFieldEmail.trailingAnchor.constraint(equalTo:
                                                        contentWrapper.trailingAnchor,
            constant: -16),
            
            textFieldPhone.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPhone.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPhone.leadingAnchor.constraint(equalTo:contentWrapper.leadingAnchor, constant:
            16),
            textFieldPhone.trailingAnchor.constraint(equalTo:
                                                        contentWrapper.trailingAnchor,
            constant: -16),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldPhone.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo:
                                                        contentWrapper.leadingAnchor, constant:
            16),
            textFieldPassword.trailingAnchor.constraint(equalTo:
                                                        contentWrapper.trailingAnchor,
            constant: -16),
            
            textFieldVerifyPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            textFieldVerifyPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldVerifyPassword.leadingAnchor.constraint(equalTo:
                                                        contentWrapper.leadingAnchor, constant:
            16),
            textFieldVerifyPassword.trailingAnchor.constraint(equalTo:
                                                        contentWrapper.trailingAnchor,
            constant: -16),
            
            
            
            
            buttonRegister.topAnchor.constraint(equalTo: textFieldVerifyPassword.bottomAnchor, constant: 16),
            buttonRegister.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonRegister.leadingAnchor.constraint(equalTo:
                                                        contentWrapper.leadingAnchor, constant:
            16),
            buttonRegister.trailingAnchor.constraint(equalTo:
                                                            contentWrapper.trailingAnchor,
            constant: -16),
            
            buttonLogin.topAnchor.constraint(equalTo: buttonRegister.bottomAnchor, constant: 16),
            buttonLogin.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonLogin.leadingAnchor.constraint(equalTo:
                                                        contentWrapper.leadingAnchor, constant:
            16),
            buttonLogin.bottomAnchor.constraint(equalTo: contentWrapper.contentLayoutGuide.bottomAnchor)


           
            
        ])
        contentWrapper.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
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
