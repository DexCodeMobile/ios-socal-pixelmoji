//
//  BaseView.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/14/22.
//

import UIKit

class BaseView: UIView {
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        fatalError("It must override \(#function).")
    }
}
