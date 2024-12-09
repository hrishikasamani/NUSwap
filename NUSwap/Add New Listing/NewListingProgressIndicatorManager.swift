//
//  NewListingProgressIndicatorManager.swift
//  NUSwap
//
//  Created by Dhruv Doshi on 12/6/24.
//

import Foundation

extension NewListingViewController:ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
