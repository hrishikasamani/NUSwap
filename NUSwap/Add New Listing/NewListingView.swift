//
//  NewListing.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit

class NewListingView: UIView {
    
    var productName: UITextField!
    var buttonTakePhoto: UIButton!
    var imageLabel: UILabel!
    var categoryLabel: UILabel!
    var categoryPickerView: UIPickerView!
    var priceLabel: UILabel!
    var priceTextField: UITextField!
    var detailsLabel: UILabel!
    var detailsTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupProductName()
        setupbuttonTakePhoto()
        setupImageLabel()
        setupCategoryLabel()
        setupCategoryPickerView()
        setupPriceLabel()
        setupPriceTextField()
        setupDetailsLabel()
        setupDetailsTextField()

        initConstraints()
    }
    
//    MARK: methods to initialize the UI elements...
    func setupProductName(){
        productName = UITextField()
        productName.placeholder = "Name of product"
        productName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(productName)
    }
    
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }
    
    func setupImageLabel(){
        imageLabel = UILabel()
        imageLabel.text = "Photo"
        imageLabel.textColor = .gray
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageLabel)
    }
    
    func setupCategoryLabel(){
        categoryLabel = UILabel()
        categoryLabel.text = "Select Category"
        categoryLabel.font = categoryLabel.font.withSize(24)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoryLabel)
    }
    
    func setupCategoryPickerView(){
        categoryPickerView = UIPickerView()
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryPickerView)
    }
    
    func setupPriceLabel(){
        priceLabel = UILabel()
        priceLabel.text = "Base Price"
        priceLabel.font = priceLabel.font.withSize(20)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(priceLabel)
    }
    
    func setupPriceTextField(){
        priceTextField = UITextField()
        priceTextField.placeholder = "Put amount in $"
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceTextField)
    }
    
    func setupDetailsLabel(){
        detailsLabel = UILabel()
        detailsLabel.text = "More Details"
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailsLabel)
    }
    
    func setupDetailsTextField(){
        detailsTextField = UITextField()
        detailsTextField.placeholder = "Add more details here"
        detailsTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailsTextField)
    }


    //MARK: initialize the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            productName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonTakePhoto.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 16),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),
            
            imageLabel.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 6),
            imageLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            categoryLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 16),
            
            categoryPickerView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 0),
            categoryPickerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            categoryPickerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            categoryPickerView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            categoryPickerView.heightAnchor.constraint(equalToConstant: 105),
            
            priceLabel.topAnchor.constraint(equalTo: categoryPickerView.bottomAnchor, constant: 32),
            priceLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: -75),
            priceLabel.widthAnchor.constraint(equalToConstant: 150),
            
            priceTextField.topAnchor.constraint(equalTo: categoryPickerView.bottomAnchor, constant: 32),
            priceTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 75),
            priceTextField.widthAnchor.constraint(equalToConstant: 150),
            
            detailsLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 32),
            detailsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            
            detailsTextField.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 20),
            detailsTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            detailsTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            

        ])
    }
    
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
