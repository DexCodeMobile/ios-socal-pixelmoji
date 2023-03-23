//
//  ItemStackable.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/13/22.
//

import Foundation

protocol ItemStackable {
    associatedtype StackableItem
    var stackableItems: [StackableItem] { get }
}
