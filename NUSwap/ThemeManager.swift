//
//  ThemeManager.swift
//  NUSwap
//
//  Created by Hrishika Samani on 12/7/24.
//

import Foundation
import UIKit

class ThemeManager {
    // Apply the default theme to a specific view
    static func applyDefaultTheme(to view: UIView) {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        applyTheme(isDarkMode: isDarkMode, to: view)
    }
    
    // Apply theme to a view based on dark mode setting
    static func applyTheme(isDarkMode: Bool, to view: UIView) {
        // Update the user interface style for the window
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows.first {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
        
        // Update the navigation bar appearance
        UINavigationBar.appearance().barStyle = isDarkMode ? .black : .default
        UINavigationBar.appearance().tintColor = isDarkMode ? .white : .black
        
        let titleColor = isDarkMode ? UIColor.white : UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: titleColor
        ]
        
        // Apply background color to the root view and recursively to its subviews
        updateBackgroundColors(for: view, isDarkMode: isDarkMode)
        
        // Update text colors for labels and other text elements
        updateTextColors(for: view, isDarkMode: isDarkMode)
    }
    // Recursively update the background color of the view and its subviews
    private static func updateBackgroundColors(for view: UIView, isDarkMode: Bool) {
        view.backgroundColor = isDarkMode ? UIColor.black : UIColor.white
        
        // Recursively apply background color to subviews
        for subview in view.subviews {
            updateBackgroundColors(for: subview, isDarkMode: isDarkMode)
        }
    }
    
    // Recursively update text color for all labels and text-containing views
    private static func updateTextColors(for view: UIView, isDarkMode: Bool) {
        let textColor = isDarkMode ? UIColor.white : UIColor.black
        
        // Check if the view is a label, and update the text color
        if let label = view as? UILabel {
            label.textColor = textColor
        }
        
        // Recursively update text colors for subviews
        for subview in view.subviews {
            updateTextColors(for: subview, isDarkMode: isDarkMode)
        }
    }
}

