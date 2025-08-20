//
//  UserStorage.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 15.08.2025.
//
import Foundation

class UserStorage {
    private let userNameKey = "userKey"
    
    func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: userNameKey)
    }
    
    func getUserName() -> String? {
        UserDefaults.standard.string(forKey: userNameKey)
    }
    
    func clearUserName() {
        UserDefaults.standard.removeObject(forKey: userNameKey)
    }
}
