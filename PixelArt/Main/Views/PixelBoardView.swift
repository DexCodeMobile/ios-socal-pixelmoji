//
//  PixelBoardView.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/14/22.
//

import UIKit

final class PixelBoardView: BaseView {
    // MARK: IBOutlets
    @IBOutlet private weak var pixcelBoard: UICollectionView!
    @IBOutlet private var panGesture: UIPanGestureRecognizer!
    @IBOutlet private var tapGesture: UITapGestureRecognizer!
    
    // MARK: Internals
    weak var delegate: UICollectionViewDelegate?
    weak var dataSource: UICollectionViewDataSource?
    var didPanPiece: ((UIPanGestureRecognizer) -> Void)?
    
    // MARK: Overrides
    convenience init(target: Any) {
        self.init()
        commonInit()
        pixcelBoard.delegate = target as? UICollectionViewDelegate
        pixcelBoard.dataSource = target as? UICollectionViewDataSource
        pixcelBoard.register(PixelCell.self, forCellWithReuseIdentifier: String(describing: PixelCell.self))
        tapGesture.delegate = target as? UIGestureRecognizerDelegate
    }
    
    override func commonInit() {
        let containerView = loadNib(named: PixelBoardView.self)
        addConstraintSubview(containerView)
        setupUI()
    }
    
    @IBAction func panPiece(_ sender: UIPanGestureRecognizer) {
        didPanPiece?(sender)
    }
}

// MARK: - Internals
extension PixelBoardView {
    func capturePixelBoard() -> UIImage? {
        return pixcelBoard.capturedImage
    }
    
    func reload() {
        pixcelBoard.reloadData()
    }
}

// MARK: - Privates
extension PixelBoardView {
    private func setupUI() {
        backgroundColor = .clear
        pixcelBoard.clipsToBounds = true
        pixcelBoard.layer.cornerRadius = 5.0
    }
}
