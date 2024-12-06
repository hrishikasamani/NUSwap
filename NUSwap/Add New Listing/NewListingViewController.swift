//
//  NewListingViewController.swift
//  NUSwap2
//
//  Created by Hrishika Samani on 11/4/24.
//

import UIKit
import FirebaseAuth

class NewListingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var newListingScreen = NewListingView()
    var selectedType = "Electronics"
    var selectedImage: UIImage?
    var uploadedImageURL: String? // Declare a local variable to store the URL
    
    override func loadView() {
        view = newListingScreen
        newListingScreen.categoryPickerView.dataSource = self
        newListingScreen.categoryPickerView.delegate = self
        newListingScreen.detailsTextField.delegate = self
        newListingScreen.productName.delegate = self
        newListingScreen.locationTextField.delegate = self
        newListingScreen.sealDealTextField.delegate = self
        newListingScreen.priceTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Set delegates
        newListingScreen.detailsTextField.delegate = self
        newListingScreen.categoryPickerView.dataSource = self
        newListingScreen.categoryPickerView.delegate = self
        newListingScreen.detailsTextField.delegate = self
        newListingScreen.productName.delegate = self
        newListingScreen.locationTextField.delegate = self
        
        // Button actions
        newListingScreen.buttonTakePhoto.addTarget(self, action: #selector(showPhotoOptions), for: .touchUpInside)
        newListingScreen.listItemButton.addTarget(self, action: #selector(addListing), for: .touchUpInside)
        
        // hide keyboard when tapped outside text fields
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        // keyboard notification observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        // remove observers
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // make sure keyboard doesn't cover text fields
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let extraPadding: CGFloat = 20
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + extraPadding, right: 0)
        newListingScreen.scrollView.contentInset = contentInset
        newListingScreen.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        newListingScreen.scrollView.contentInset = contentInset
        newListingScreen.scrollView.scrollIndicatorInsets = contentInset
    }
    
    private func scrollToView(view: UIView) {
        guard let scrollView = newListingScreen.scrollView else { return }
        let frame = view.convert(view.bounds, to: scrollView)
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollToView(view: textField)
    }
    
    // when user types in description box
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollToView(view: textView)
        if textView.text == "Enter detailed description here..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    // when description box is blank
    @objc func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter detailed description here..."
            textView.textColor = .lightGray
        }
    }
    
    // MARK: - Show Photo Options
    @objc func showPhotoOptions() {
        let alert = UIAlertController(title: "Upload Photo", message: "Choose a photo from gallery or take a new one.", preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.openGallery()
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(galleryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        } else {
            showErrorAlert(message: "Gallery is not available.")
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
        } else {
            showErrorAlert(message: "Camera is not available.")
        }
    }
    
    // MARK: - Image Picker Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.selectedImage = selectedImage
                self.newListingScreen.buttonTakePhoto.setImage(selectedImage, for: .normal)
                self.newListingScreen.buttonTakePhoto.contentMode = .scaleAspectFit
                
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    // hide keyboard
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }
    
    // MARK: - Error Alert
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - UIPickerView DataSource and Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utilities.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Utilities.types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = Utilities.types[row]
    }
}
