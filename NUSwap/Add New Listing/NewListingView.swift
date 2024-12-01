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
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.delegate = self // Set the delegate
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
        detailsTextField.layer.borderWidth = 1.0
        detailsTextField.layer.cornerRadius = 5.0
        detailsTextField.isScrollEnabled = true
        detailsTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailsTextField)
    }
    
    func setupListItemButton() {
        listItemButton = UIButton(type: .system)
        listItemButton.setTitle("List your item", for: .normal)
        listItemButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        listItemButton.backgroundColor = .systemBlue
        listItemButton.setTitleColor(.white, for: .normal)
        listItemButton.layer.cornerRadius = 10
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Define the character limit
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        // Define character limits based on the text field
        let maxLength: Int
        if textField == productName {
            maxLength = 30 // Max length for productName
        } else if textField == detailsTextField {
            maxLength = 100 // Max length for detailsTextField
        } else {
            maxLength = 30 // Default max length if needed
        }

        if updatedText.count > maxLength {
            return false
        }
        if textField == priceTextField || textField == sealDealTextField {
            // Ensure only valid characters are entered
            let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
            if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
                return false
            }
            // Allow empty text
            if updatedText.isEmpty { return true }
            
            // Ensure only one decimal point
            if updatedText.filter({ $0 == "." }).count > 1 {
                return false
            }
            
            // Restrict to two decimal places
            if let decimalIndex = updatedText.firstIndex(of: ".") {
                let decimalPart = updatedText[decimalIndex...].dropFirst() // Get characters after "."
                if decimalPart.count > 2 {
                    return false
                }
            }
        }
        return true
    }

}
