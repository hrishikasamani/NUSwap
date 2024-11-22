//
//  NewListingViewController.swift
//  NUSwap2
//
//  Created by Hrishika Samani on 11/4/24.
//

import UIKit

class NewListingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var newListingScreen = NewListingView()
    var selectedType = "Electronics"

    override func loadView() {
        view = newListingScreen
        newListingScreen.categoryPickerView.dataSource = self
        newListingScreen.categoryPickerView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Add target for the photo button
        newListingScreen.buttonTakePhoto.addTarget(self, action: #selector(showPhotoOptions), for: .touchUpInside)
    }

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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.newListingScreen.buttonTakePhoto.setImage(selectedImage, for: .normal)
                self.newListingScreen.buttonTakePhoto.contentMode = .scaleAspectFit
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension NewListingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utilities.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedType = Utilities.types[row]
        return Utilities.types[row]
    }
}
