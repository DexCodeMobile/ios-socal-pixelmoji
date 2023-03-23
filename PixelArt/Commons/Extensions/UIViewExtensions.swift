//
//  UIViewExtensions.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/13/22.
//

import Foundation
import UIKit

// MARK: - AutoLayouts
extension UIView {
    func addConstraintSubview(_ view: UIView, edgeInset: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor, constant: edgeInset.top).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInset.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInset.left).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edgeInset.right).isActive = true
    }
}

extension UIView {
    var capturedImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
