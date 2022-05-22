//
//  UIView+Shadow.swift
//  FakeStore
//
//  Created by Arman Karimov on 21.05.2022.
//

import UIKit

extension UIView {
    
    func dropShadow() {
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowColor = UIColor.systemBackground.inverted.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
    }
    
}
