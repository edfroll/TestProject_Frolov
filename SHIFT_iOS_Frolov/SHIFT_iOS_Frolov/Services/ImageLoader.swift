//
//  ImageLoader.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 15.08.2025.
//

import UIKit

class ImageLoader {
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            //callback с передачей неудачного запроса
            completion(nil)
            return
        }
        // Загрузка изображения из url и приведение к UIImage в фоновом потоке
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    //callback с передачей неудачного запроса
                    completion(nil)
                }
            }
        }
    }
}
