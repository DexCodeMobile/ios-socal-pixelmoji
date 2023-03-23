//
//  SeparateBarView.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/14/22.
//

import UIKit

final class SeparateBarView: BaseView {

    // MARK: IBOutlets
    @IBOutlet private weak var lineView: UIView!
    
    // MARK: Overrides
    override func commonInit() {
        let containerView = loadNib(named: SeparateBarView.self)
        addConstraintSubview(containerView)
        lineView.backgroundColor = .white
    }
}
