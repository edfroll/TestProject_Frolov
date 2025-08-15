//
//  FetchPost.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 14.08.2025.
//

import Foundation

class MainSceneViewModel {
    
    // MARK: - Данные
    // Массив для загруженных продуктов
    var products: [Product] = []
    
    // MARK: - Обработка данных
    func fetchProducts(completion: @escaping () -> Void) {
        // Создание URL
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }

        // Создание сетовоего запроса на URL
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            // Проверка на self
            guard let self = self else { return }
            
            // Проверка на ошибки сети
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            // Проверка на наличие данных
            guard let data = data else {
                print("Нет данных")
                return
            }
            
            // Парсинг JSON
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                self.products = products
                
                
                //"Escape" на главный поток через GCD для обновления таблицы
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print("Ошибка парсинга \(error.localizedDescription)")
            }
        }
        // Запуск запроса
        task.resume()
    }
}
