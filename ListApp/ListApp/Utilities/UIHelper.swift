//
//  UIHelper.swift
//  ListApp
//
//  Created by Диана Мишкова on 19.10.24.
//

import UIKit

struct UIHelper {
    
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let itemWidth = width - (padding * 2)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 100)
        
        return flowLayout
    }
    
}

