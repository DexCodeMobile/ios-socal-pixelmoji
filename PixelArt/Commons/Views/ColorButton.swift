//
//  ColorButton.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/14/22.
//

import UIKit

// MARK: - ColorButton
class ColorButton: UIButton {
    // MARK: Privates
    private var selectedBorderColor: CGColor = UIColor.white.cgColor
    private var isBackgroundWhite: Bool {
        return backgroundColor?.toHex() == "FFFFFFFF"
    }
    
    // MARK: Internals
    var color: UIColor? {
        didSet {
            backgroundColor = color
            selectedBorderColor = isBackgroundWhite ? UIColor.darkGray.cgColor : UIColor.white.cgColor
        }
    }
    var isColorButtonSelected: Bool = false {
        didSet {
            addBorder(isColorButtonSelected)
        }
    }
    var didTap: ((ColorButton) -> Void)?
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

// MARK: - Privates
extension ColorButton {
    private func commonInit() {
        layer.cornerRadius = 5.0
        clipsToBounds = true
        
        addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
    }
    
    @objc private func handleTap(_ button: ColorButton) {
        didTap?(button)
    }
    
    private func addBorder(_ show: Bool) {
        viewWithTag(1000)?.removeFromSuperview()
        if show {
            let view = UIView()
            view.tag = 1000
            view.backgroundColor = .clear
            view.layer.borderWidth = 3.0
            view.layer.borderColor = selectedBorderColor
            view.layer.cornerRadius = 5.0
            view.clipsToBounds = true
            addConstraintSubview(view, edgeInset: UIEdgeInsets(top: 4.0, left: 4.0, bottom: -4.0, right: -4.0))
        }
    }
}
