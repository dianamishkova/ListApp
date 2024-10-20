//
//  ItemCollectionViewCell.swift
//  ListApp
//
//  Created by Диана Мишкова on 19.10.24.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    static let reuseID = "ItemCell"
    
    private let itemImageView = ItemImageView(frame: .zero)
    private let nameLabel = ItemTitleLabel(textAlignment: .left, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(item: PhotoTypeDtoOut) {
        nameLabel.text = item.name
        itemImageView.downloadImage(from: item.image)
    }
    
    private func configure() {
        addSubview(nameLabel)
        addSubview(itemImageView)
        
        let padding: CGFloat = 8
        

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: itemImageView.leadingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            itemImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            itemImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            itemImageView.heightAnchor.constraint(equalToConstant: 70),
            itemImageView.widthAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    
}
