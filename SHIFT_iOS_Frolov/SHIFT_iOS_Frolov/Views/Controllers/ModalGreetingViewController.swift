//
//  ModalGreetingViewController.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 13.08.2025.
//

import UIKit

class ModalGreetingViewController: UIViewController {
    
    let textLabel: String
    
    // MARK: - Инициализаторы
    init(textLabel: String) {
        self.textLabel = textLabel
        super.init(nibName: nil, bundle: nil)
    }
    
    // Обязательный инициализатор для сториборда
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Метод жизненного цикла
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        greetingLabel.text = textLabel
        view.addSubview(greetingLabel)
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    // MARK: - Label
    lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
}
