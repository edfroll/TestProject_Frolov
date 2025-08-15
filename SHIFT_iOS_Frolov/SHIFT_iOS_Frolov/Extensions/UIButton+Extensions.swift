//
//  UIButton+Extensions.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 09.08.2025.
//

import UIKit

extension UIButton {
    func applyPrimaryStyle(title: String) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        self.configuration = config
    }
}

