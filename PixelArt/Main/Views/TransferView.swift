//
//  TransferView.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/13/22.
//

import UIKit

final class TransferView: BaseView {
    // MARK: IBOutlet
    @IBOutlet private weak var shareButton: ToolButton!
    
    // MARK: Internals
    var didTapShareButton: (() -> Void)?
    
    // MARK: Overrides
    override func commonInit() {
        let containerView = loadNib(named: TransferView.self)
        addConstraintSubview(containerView)
        setupUI()
    }
    
    // MARK: - IBAction
    @IBAction func didTapShareButton(_ sender: Any) {
        didTapShareButton?()
    }
}

// MARK: - Privates
extension TransferView {
    
    private func setupUI() {
        backgroundColor = .clear
        shareButton.setTitle("", for: .normal)
    }
}
