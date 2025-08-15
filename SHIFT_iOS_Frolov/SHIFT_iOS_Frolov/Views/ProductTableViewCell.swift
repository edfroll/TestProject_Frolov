//
//  CustomCell.swift
//  SHIFT_IOS
//
//  Created by Эдвард on 14.08.2025.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    // Подключение к сервису загрузки изображений
    private let imageLoader = ImageLoader()
    
    // MARK: - Подэлементы ячейки
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Инициализаторы
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        //self.imageLoader = ImageLoader()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    // MARK: - Добавление и размещение подэлементов в иерархии
    private func setupCell() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Internal метод конфигурации кастомной ячейки
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "Цена: \(product.price) $"
        productImageView.image = nil
        
        imageLoader.loadImage(from: product.image) { [weak self] image in
            self?.productImageView.image = image
        }
    }
    
}
