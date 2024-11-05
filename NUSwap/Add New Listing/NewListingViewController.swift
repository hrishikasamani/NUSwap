//
//  NewListingViewController.swift
//  NUSwap2
//
//  Created by Hrishika Samani on 11/4/24.
//

import UIKit

class NewListingViewController: UIViewController {
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
        // Do any additional setup after loading the view.
    }
    


}

extension NewListingViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //MARK: we are using only one section...
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //MARK: we are displaying the options from Utilities.types...
        return Utilities.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //MARK: updating the selected type when the user picks this row...
        selectedType = Utilities.types[row]
        return Utilities.types[row]
    }
}
