//
//  ToolsView.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/14/22.
//

import UIKit

final class ToolsView: BaseView {
    // MARK: IBOutlet
    @IBOutlet private weak var borderButton: ToolButton!
    @IBOutlet private weak var undoButton: ToolButton!
    @IBOutlet private weak var resetButton: ToolButton!
    @IBOutlet private weak var eraseButton: ToolButton!
    
    // MARK: Internals
    var didTapBorderButton: (() -> Void)?
    var didTapUndoButton: (() -> Void)?
    var didTapResetButton: (() -> Void)?
    var didTapEraseButton: (() -> Void)?
    
    // MARK: Overrides
    override func commonInit() {
        let containerView = loadNib(named: ToolsView.self)
        addConstraintSubview(containerView)
        setupUI()
    }
    
    // MARK: - IBAction
    @IBAction func didTapBorderButton(_ sender: Any) {
        borderButton.toggleBorder()
        didTapBorderButton?()
    }
    
    @IBAction func didTapUndoButton(_ sender: Any) {
        didTapUndoButton?()
    }
    
    @IBAction func didTapResetButton(_ sender: Any) {
        didTapResetButton?()
    }
    
    @IBAction func didTapEraseButton(_ sender: Any) {
        eraseButton.toggleBorder()
        didTapEraseButton?()
    }
}

extension ToolsView {
    func eraseButtonToggleOff() {
        eraseButton.layer.borderWidth = 0.0
    }
}

// MARK: - Privates
extension ToolsView {
    private func setupUI() {
        backgroundColor = .clear
        borderButton.setTitle("", for: .normal)
        borderButton.toggleBorder()
        undoButton.setTitle("", for: .normal)
        eraseButton.setTitle("", for: .normal)
        resetButton.setTitle("", for: .normal)
    }
}
