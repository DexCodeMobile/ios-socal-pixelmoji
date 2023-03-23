//
//  HistoryStack.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/15/22.
//

import Foundation
import UIKit

struct HistoryStack {
    private var historyStack: [[IndexPath: UIColor]] = []
    
    mutating func push(_ item: [IndexPath: UIColor]) {
        guard !item.isEmpty else { return }
        historyStack.append(item)
        print("HistoryStack Push: \(historyStack.count)")
    }
    
    mutating func pop() {
        guard historyStack.count > 0 else { return }
        historyStack.removeLast()
        print("HistoryStack Pop: \(historyStack.count)")
    }
    
    mutating func removeAll() {
        historyStack.removeAll()
    }
    
    func color(_ key: IndexPath) -> UIColor? {
        let color = historyStack.compactMap({ $0[key] }).first
        print("HistoryStack key \(key) => \(String(describing: color))")
        return color
    }
}
