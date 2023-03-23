//
//  PixelCell.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/14/22.
//

import UIKit

final class PixelCell: UICollectionViewCell {
    private(set) var indexPath: IndexPath?
    
    func configure(color: UIColor, needBorder: Bool = true, indexPath: IndexPath? = nil, debugMode: Bool = false) {
        backgroundColor = color
        if needBorder {
            layer.borderColor = UIColor.cellBorderColor?.cgColor
            layer.borderWidth = 0.4
        } else {
            layer.borderWidth = 0.0
        }
        
        self.indexPath = indexPath
        
        // Debug Mode
        subviews.first(where: { $0 is UILabel })?.removeFromSuperview()
        if debugMode, let indexPath = indexPath {
            let label = UILabel(frame: frame)
            label.text = "(\(indexPath.item),\(indexPath.section))"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 5.0)
            addConstraintSubview(label)
            bringSubviewToFront(label)
        }
    }
}
