//
//  ViewModel.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 09.08.2025.
//

import Foundation

struct ValidRegisterViewModel {
    
    func validUserRegister(data: RegistrationData) -> (isValid: Bool, message: String) {
        if data.name.isEmpty || data.name.count <= 1 {
            return (false, "Пожалуйста, введите имя")
        }
        if data.surname.isEmpty || data.surname.count <= 1 {
            return (false, "Пожалуйста, введите фамилию")
        }
        if data.birthday.isEmpty {
            return (false, "Пожалуйста, выберите дату рождения")
        }
        if data.password.count < 6 {
            return (false, "Пароль должен содержать не менее 6 символов")
        }
        if !data.password.contains(where: { $0.isLetter }) {
            return (false, "Пароль должен содержать хотя бы одну букву")
        }
        if !data.password.contains(where: { $0.isNumber }) {
            return (false, "Пароль должен содержать хотя бы одну цифру")
        }
        if data.confirmPassword != data.password {
            return (false, "Пароли не совпадают")
        }
        return (true, "Регистрация успешна!")
    }
}
