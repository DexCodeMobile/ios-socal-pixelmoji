//
//  NibFileLoadable.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/13/22.
//

import UIKit
import Foundation

protocol NibFileLoadable { }
extension NibFileLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        let identifiedNib = UINib(nibName: String(describing: self), bundle: .main)
        guard let view = identifiedNib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(identifiedNib) expected its root view to be of type \(self)")
        }
        return view
    }
    
    func loadNib<T>(named instance: T, from bundle: Bundle = .main) -> UIView {
        guard let view = bundle.loadNibNamed(String(describing: instance.self), owner: self)?.first as? UIView else {
            fatalError("The nib \(instance) expected its root view to be of type \(self).")
        }
        return view
    }
}

extension UIView: NibFileLoadable { }
