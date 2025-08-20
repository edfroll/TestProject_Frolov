//
//  ViewController.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 08.08.2025.

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Подключение ViewModel и UserStorage Service
    private let viewModel = ValidRegisterViewModel()
    private let userStorage = UserStorage()
    
    // MARK: - Метод жизненного цикла
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userStorage.getUserName() != nil {
            pushOn(vc: MainSceneViewController())
        }
        
        setupUI()
        setupActions()
    }
    
    // MARK: - Установка UI
    private func setupUI() {
        title = "Регистрация"
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        birthdayTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        birthdayTextField.inputView = datePicker
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(surnameTextField)
        stackView.addArrangedSubview(birthdayTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(buttonRegister)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        ])
    }
    
    // MARK: - Инициализация UI элементов
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.applyPrimaryStyle(placeholder: "Введите ваше имя")
        return textField
    }()
    
    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.applyPrimaryStyle(placeholder: "Введите вашу фамилию")
        return textField
    }()
    
    private let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.applyPrimaryStyle(placeholder: "Выберите дату рождения")
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.applyPrimaryStyle(placeholder: "Введите пароль")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.applyPrimaryStyle(placeholder: "Подтвердите пароль")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let buttonRegister: UIButton = {
        let button = UIButton()
        button.applyPrimaryStyle(title: "Регистрация")
        return button
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    // MARK: - UI Actions
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        buttonRegister.addTarget(self, action: #selector(buttonRegisterTapped), for: .touchUpInside)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func setDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ru_RU")
        birthdayTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func buttonRegisterTapped() {
        let registrationData = RegistrationData(
            name: nameTextField.text ?? "",
            surname: surnameTextField.text ?? "",
            birthday: birthdayTextField.text ?? "",
            password: passwordTextField.text ?? "",
            confirmPassword: confirmPasswordTextField.text ?? ""
        )
        
        let result = viewModel.validUserRegister(data: registrationData)
        
        if !result.isValid {
            showAlert(actionTitle: "Закрыть", message: result.message)
        } else {
            userStorage.saveUserName(registrationData.name)
            
            showAlert(actionTitle: "Продолжить", message: result.message)
            { [weak self] in self?.pushOn(vc: MainSceneViewController()) }
        }
    }
    
    private func showAlert(actionTitle: String, message: String, completion: (() -> (Void))? = nil ) {
        let alert = UIAlertController(title: "Регистрация", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    
    func pushOn(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
