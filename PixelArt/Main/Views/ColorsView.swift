//
//  ColorsView.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/14/22.
//

import UIKit

final class ColorsView: BaseView {
    // MARK: IBOutlet
    @IBOutlet private weak var currentColorView: UIView!
    @IBOutlet private weak var colorsVStackView: UIStackView!
    
    // MARK: Internals
    var currentColor: UIColor = .black {
        didSet {
            currentColorView.backgroundColor = currentColor
            markSelectedButton()
        }
    }
    var didTapColorButton: ((UIColor) -> Void)?
    
    // MARK: Privates
    private let colors: [String] = [
        "000000FF",
        "0B64EEFF",
        "1AB942FF",
        "F5DE0AFF",
        "E7312AFF",
        "FFFFFFFF",
        "9A1CF4FF",
        "57EA7EFF",
        "FF9900FF",
        "8A8A8AFF"
    ]
    
    // MARK: Overrides
    override func commonInit() {
        let containerView = loadNib(named: ColorsView.self)
        addConstraintSubview(containerView)
        setupUI()
    }
}

// MARK: - Privates
extension ColorsView {
    private func setupUI() {
        backgroundColor = .clear
        currentColorView.backgroundColor = currentColor
        currentColorView.layer.cornerRadius = 5.0
        
        colorsVStackView.backgroundColor = .clear
        colorsVStackView.translatesAutoresizingMaskIntoConstraints = false
        colorsVStackView.spacing = 8.0
        colorsVStackView.distribution = .fillEqually
        
        for idx in 0..<2 {
            let from = idx * colors.count/2
            let to = colors.count/2 + (colors.count/2 * idx)
            let vStackView = UIStackView(arrangedSubviews: colors[from..<to].map { color in
                let button = ColorButton()
                button.color = UIColor(hex: color)
                button.isColorButtonSelected = color == .whiteHexString
                button.didTap = didTapColorButton
                return button
            })
            vStackView.backgroundColor = .clear
            vStackView.axis = .horizontal
            vStackView.distribution = .fillEqually
            vStackView.spacing = 14.0
            
            colorsVStackView.addArrangedSubview(vStackView)
        }
    }
    
    @objc private func didTapColorButton(_ button: ColorButton) {
        let color = button.color ?? .white
        didTapColorButton?(color)
        currentColor = color
    }
    
    private func markSelectedButton() {
        colorsVStackView.arrangedSubviews.forEach {
            guard let stackView = $0 as? UIStackView else { return }
            stackView.arrangedSubviews.forEach {
                if let button = $0 as? ColorButton {
                    button.isColorButtonSelected =  button.color?.toHex() == currentColor.toHex()
                }
            }
        }
    }
}
