//
//  MainSceneViewController.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 09.08.2025.
//

import UIKit

class MainSceneViewController: UIViewController {
    
    // MARK: - Подключение ViewModel и UserStorage Service
    private let viewModel = MainSceneViewModel()
    private let userStorage = UserStorage()

    // MARK: - Жизненный цикл, инициализация MainScene
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Кнопка "Выйти"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Выйти",
            style: .plain,
            target: self,
            action: #selector(logout)
            )
        
        navigationItem.hidesBackButton = true
        
        view.addSubview(tableView)
        view.addSubview(buttonGreeting)
        setupConstraints()
        
        viewModel.fetchProducts { [weak self] in self?.tableView.reloadData() }
        buttonGreeting.addTarget(self, action: #selector(actionGreeting), for: .touchUpInside)
        
    }
    
    // MARK: - Таблица
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.rowHeight = 80
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Кнопка "Приветствие"
    lazy var buttonGreeting: UIButton = {
        let button = UIButton()
        button.applyPrimaryStyle(title: "Приветствие")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Установка констрейнтов
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            buttonGreeting.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonGreeting.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Actions
    @objc private func actionGreeting() {
        let userName = userStorage.getUserName() ?? "Гость"
        
        let modalVC = ModalGreetingViewController(textLabel: "Здравствуйте, \(userName)")
        modalVC.modalPresentationStyle = .pageSheet
        modalVC.modalTransitionStyle = .crossDissolve
        
        present(modalVC, animated: true)
    }
    
    @objc private func logout() {
        userStorage.clearUserName()
        navigationController?.popToRootViewController(animated: true)
    }
    
}


// MARK: - Расширение для UITableView
extension MainSceneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let product = viewModel.products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    // По ТЗ делегат не требуется
    
}
