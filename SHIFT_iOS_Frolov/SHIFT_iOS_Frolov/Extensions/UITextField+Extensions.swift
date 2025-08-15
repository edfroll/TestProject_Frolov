//
//  UITextField+Extensions.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 11.08.2025.
//
import UIKit

extension UITextField {
    func applyPrimaryStyle(placeholder: String) {
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.clearButtonMode = .whileEditing

        
    }
}
