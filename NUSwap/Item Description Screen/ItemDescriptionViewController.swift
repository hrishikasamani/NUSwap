//
//  ItemDescriptionViewViewController.swift
//  NUSwap
//
//  Created by Karyn T on 10/27/24.
//

import UIKit

class ItemDescriptionViewController: UIViewController {
    
    var itemDescriptionScreen = ItemDescriptionView()
    
    override func loadView() {
        view = itemDescriptionScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hideKeyboardOnTapOutside()
        
    }
    
    
    // hides keyboard
    func hideKeyboardOnTapOutside() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }

    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }


}
