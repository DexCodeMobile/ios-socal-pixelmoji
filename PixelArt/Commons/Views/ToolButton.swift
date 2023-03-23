//
//  ToolButton.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/14/22.
//

import UIKit

// MARK: - ToolButton
class ToolButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        layer.cornerRadius = 5.0
    }
    
    func toggleBorder() {
        layer.borderWidth = layer.borderWidth == 0.0 ? 2.0 : 0.0
    }
}
