//
//  UIStackViewExtensions.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/13/22.
//

import UIKit
import Foundation

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
    
    func addSubView<T>() -> T where T: UIView {
        let container = T()
        container.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(container)
        return container
    }
}
