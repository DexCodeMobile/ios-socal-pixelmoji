//
//  PixelArtViewModel.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/13/22.
//

import UIKit
import Foundation

// MARK: - PixelTool
enum PixelTool {
    case undo
    case reset
    case erase
    case drawing
    case none
}

// MARK: - StackableItem
enum StackableItem {
    case transfer
    case pixelBoard
    case tools
    case separateBar
    case colors
}

final class MainViewModel: ItemStackable {
    // MARK: Privates
    private let kCurrentColor: String = "currentColor"
    private var historyStack: HistoryStack = HistoryStack()
    
    // MARK: Internals
    var stackableItems: [StackableItem] {
        return [
            .transfer,
            .pixelBoard,
            .tools,
            .separateBar,
            .colors
        ]
    }
    var currentTool: PixelTool = .none
    var currentColorValue: String {
        get {
            return UserDefaults.standard.string(forKey: kCurrentColor) ?? .blackHexString
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kCurrentColor)
        }
    }
    var shouldShowBorder: Bool = true
    var drawingCells: [IndexPath: UIColor] = [:]
    
    // MARK: DebugMode
    var showCellIndexInDebugMode: Bool = false
}

// MARK: - Internals
extension MainViewModel {
    func storeDrawingCells() {
        historyStack.push(drawingCells)
        drawingCells.removeAll()
        print("\(historyStack)")
    }
    
    func undo() {
        historyStack.pop()
    }
    
    func reset() {
        historyStack.removeAll()
    }
    
    func color(for key: IndexPath) -> UIColor? {
        return historyStack.color(key)
    }
    
    func loadExamplePixelMoji() {
        var cells: [[IndexPath: UIColor]] = [
            [IndexPath(item: 1, section: 3): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 2, section: 3): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 1, section: 4): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 2, section: 4): UIColor(hex: "E7312AFF")!],
            
            [IndexPath(item: 6, section: 1): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 6, section: 2): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 7, section: 1): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 7, section: 2): UIColor(hex: "E7312AFF")!],
            
            [IndexPath(item: 12, section: 1): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 13, section: 1): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 12, section: 2): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 13, section: 2): UIColor(hex: "E7312AFF")!],
            
            [IndexPath(item: 17, section: 4): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 18, section: 4): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 17, section: 5): UIColor(hex: "E7312AFF")!],
            [IndexPath(item: 18, section: 5): UIColor(hex: "E7312AFF")!],
        ]
        
        // Blue
        cells.append([IndexPath(item: 15, section: 3): UIColor(hex: "0B64EEFF")!])
        for n in 6...10 { cells.append([IndexPath(item: n, section: 4): UIColor(hex: "0B64EEFF")!]) }
        for n in 14...15 { cells.append([IndexPath(item: n, section: 4): UIColor(hex: "0B64EEFF")!]) }
        for n in 5...15 { cells.append([IndexPath(item: n, section: 5): UIColor(hex: "0B64EEFF")!]) }
        for n in 5...15 { cells.append([IndexPath(item: n, section: 6): UIColor(hex: "0B64EEFF")!]) }
        for n in 5...15 { cells.append([IndexPath(item: n, section: 7): UIColor(hex: "0B64EEFF")!]) }
        for n in 5...15 { cells.append([IndexPath(item: n, section: 8): UIColor(hex: "0B64EEFF")!]) }
        for n in 5...14 { cells.append([IndexPath(item: n, section: 9): UIColor(hex: "0B64EEFF")!]) }
        cells.append([IndexPath(item: 5, section: 10): UIColor(hex: "0B64EEFF")!])
        for n in 11...13 { cells.append([IndexPath(item: n, section: 10): UIColor(hex: "0B64EEFF")!]) }
        
        // Yellow
        cells.append([IndexPath(item: 15, section: 9): UIColor(hex: "F5DE0AFF")!])
        for n in 6...10 { cells.append([IndexPath(item: n, section: 10): UIColor(hex: "F5DE0AFF")!]) }
        for n in 14...15 { cells.append([IndexPath(item: n, section: 10): UIColor(hex: "F5DE0AFF")!]) }
        for n in 5...15 { cells.append([IndexPath(item: n, section: 11): UIColor(hex: "F5DE0AFF")!]) }
        for n in 5...15 { cells.append([IndexPath(item: n, section: 12): UIColor(hex: "F5DE0AFF")!]) }
        for n in 5...15 { cells.append([IndexPath(item: n, section: 13): UIColor(hex: "F5DE0AFF")!]) }
        for n in 5...14 { cells.append([IndexPath(item: n, section: 14): UIColor(hex: "F5DE0AFF")!]) }
        for n in 5...6 { cells.append([IndexPath(item: n, section: 15): UIColor(hex: "F5DE0AFF")!]) }
        for n in 11...13 { cells.append([IndexPath(item: n, section: 15): UIColor(hex: "F5DE0AFF")!]) }
        cells.append([IndexPath(item: 5, section: 16): UIColor(hex: "F5DE0AFF")!])
        
        // Stick
        for n in 5...19 { cells.append([IndexPath(item: 4, section: n): UIColor(hex: "8A8A8AFF")!]) }
        
        cells.forEach({ historyStack.push($0) })
    }
}
