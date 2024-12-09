//
//  NewListing.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit

class NewListingView: UIView, UITextFieldDelegate {
    var scrollView: UIScrollView!
    var contentView: UIView!

    var productName: UITextField!
    var buttonTakePhoto: UIButton!
    var imageLabel: UILabel!
    var categoryLabel: UILabel!
    var categoryPickerView: UIPickerView!
    var priceLabel: UILabel!
    var priceTextField: UITextField!
    var sealDealLabel: UILabel!
    var sealDealTextField: UITextField!
    var locationLabel: UILabel!
    var locationTextField: UITextField!
    var detailsLabel: UILabel!
    var detailsTextField: UITextView!
    var listItemButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupScrollView()
        setupContentView()
        setupProductName()
        setupButtonTakePhoto()
        setupImageLabel()
        setupCategoryLabel()
        setupCategoryPickerView()
        setupPriceLabel()
        setupPriceTextField()
        setupSealDealLabel()
        setupSealDealTextField()
        setupLocationLabel()
        setupLocationTextField()
        setupDetailsLabel()
        setupDetailsTextField()
        setupListItemButton()
        
        setupConstraints()
    }

    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
    }

    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }

    func setupProductName() {
        productName = UITextField()
        productName.placeholder = "Name of product"
        productName.borderStyle = .roundedRect
        productName.layer.borderColor = UIColor.lightGray.cgColor
        productName.layer.borderWidth = 0.5
        productName.layer.cornerRadius = 5.0
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.delegate = self
        contentView.addSubview(productName)
    }

    func setupButtonTakePhoto() {
        buttonTakePhoto = UIButton(type: .custom)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonTakePhoto)
    }

    func setupImageLabel() {
        imageLabel = UILabel()
        imageLabel.text = "Photo"
        imageLabel.textColor = .gray
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageLabel)
    }

    func setupCategoryLabel() {
        categoryLabel = UILabel()
        categoryLabel.text = "Select Category"
        categoryLabel.font = categoryLabel.font.withSize(20)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)
    }

    func setupCategoryPickerView() {
        categoryPickerView = UIPickerView()
        categoryPickerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryPickerView)
    }

    func setupPriceLabel() {
        priceLabel = UILabel()
        priceLabel.text = "Base Price"
        priceLabel.font = priceLabel.font.withSize(20)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
    }

    func setupPriceTextField() {
        priceTextField = UITextField()
        priceTextField.placeholder = "Put amount in $"
        priceTextField.keyboardType = .decimalPad
        priceTextField.borderStyle = .roundedRect
        priceTextField.layer.borderColor = UIColor.lightGray.cgColor
        priceTextField.layer.borderWidth = 0.5
        priceTextField.layer.cornerRadius = 5.0
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.delegate = self
        contentView.addSubview(priceTextField)
    }

    func setupSealDealLabel() {
        sealDealLabel = UILabel()
        sealDealLabel.text = "Seal the Deal"
        sealDealLabel.font = sealDealLabel.font.withSize(20)
        sealDealLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sealDealLabel)
    }

    func setupSealDealTextField() {
        sealDealTextField = UITextField()
        sealDealTextField.placeholder = "Enter amount in $"
        sealDealTextField.keyboardType = .decimalPad
        sealDealTextField.borderStyle = .roundedRect
        sealDealTextField.layer.borderColor = UIColor.lightGray.cgColor
        sealDealTextField.layer.borderWidth = 0.5
        sealDealTextField.layer.cornerRadius = 5.0
        sealDealTextField.translatesAutoresizingMaskIntoConstraints = false
        sealDealTextField.delegate = self
        contentView.addSubview(sealDealTextField)
    }

    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.text = "Location"
        locationLabel.font = locationLabel.font.withSize(20)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
    }

    func setupLocationTextField() {
        locationTextField = UITextField()
        locationTextField.placeholder = "Enter location"
        locationTextField.borderStyle = .roundedRect
        locationTextField.layer.borderColor = UIColor.lightGray.cgColor
        locationTextField.layer.borderWidth = 0.5
        locationTextField.layer.cornerRadius = 5.0
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationTextField)
    }

    func setupDetailsLabel() {
        detailsLabel = UILabel()
        detailsLabel.text = "More Details"
        detailsLabel.font = detailsLabel.font.withSize(20)
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailsLabel)
    }

    func setupDetailsTextField() {
        detailsTextField = UITextView()
        detailsTextField.text = "Enter detailed description here..."
        detailsTextField.textColor = .lightGray
        detailsTextField.font = UIFont.systemFont(ofSize: 20)
        detailsTextField.layer.borderColor = UIColor.lightGray.cgColor
        detailsTextField.layer.borderWidth = 0.5
        detailsTextField.layer.cornerRadius = 5.0
        detailsTextField.isScrollEnabled = true
        detailsTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailsTextField)
    }
    
    func setupListItemButton() {
        listItemButton = UIButton(type: .system)
        listItemButton.setTitle("List your item", for: .normal)
        listItemButton.backgroundColor = UIColor(red: 191/255, green: 0/255, blue: 0/255, alpha: 1)
        listItemButton.setTitleColor(.white, for: .normal)
        listItemButton.layer.cornerRadius = 8
        listItemButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listItemButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            productName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            buttonTakePhoto.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 16),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),

            imageLabel.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 8),
            imageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            categoryLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 16),
            categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            categoryPickerView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            categoryPickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryPickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            categoryPickerView.heightAnchor.constraint(equalToConstant: 120),

            priceLabel.topAnchor.constraint(equalTo: categoryPickerView.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            priceTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            sealDealLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 16),
            sealDealLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            sealDealTextField.topAnchor.constraint(equalTo: sealDealLabel.bottomAnchor, constant: 8),
            sealDealTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sealDealTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            locationLabel.topAnchor.constraint(equalTo: sealDealTextField.bottomAnchor, constant: 16),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            locationTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            detailsLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 16),
            detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            detailsTextField.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 8),
            detailsTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailsTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailsTextField.heightAnchor.constraint(equalToConstant: 120),
            
            listItemButton.topAnchor.constraint(equalTo: detailsTextField.bottomAnchor, constant: 32),
            listItemButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            listItemButton.widthAnchor.constraint(equalToConstant: 200),
            listItemButton.heightAnchor.constraint(equalToConstant: 50),

            listItemButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
