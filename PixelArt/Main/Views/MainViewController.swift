//
//  MainViewController.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/13/22.
//

import UIKit

final class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    // MARK: IBOutlets
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var stackViewTopConstraint: NSLayoutConstraint!
    
    // MARK: Privates
    private var pixelBoardView: PixelBoardView!
    private var toolsView: ToolsView!
    private let viewModel: MainViewModel = MainViewModel()
    private var currentColor: UIColor {
        get {
            return UIColor(hex: viewModel.currentColorValue) ?? .black
        }
        set {
            viewModel.currentColorValue = newValue.toHex() ?? .blackHexString
        }
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

// MARK: - StackView
extension MainViewController {
    private func setupStackView() {
        view.backgroundColor = .mainBackgroundColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.removeAllArrangedSubviews()
        
        viewModel.stackableItems.forEach {
            switch $0 {
            case .transfer:
                addTransferView()
            case .pixelBoard:
                addPixelBoardView()
            case .tools:
                addToolsView()
            case .separateBar:
                addSeparateBarView()
            case .colors:
                addColorsView()
            }
        }
    }
    
    private func addTransferView() {
        let view = TransferView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(view.heightAnchor.constraint(equalToConstant: height(percent: 13)))
        view.didTapShareButton = { [weak self] in
            guard let self = self else { return }
            guard let image = self.pixelBoardView.capturePixelBoard() else { return }
            self.presentActivityView(withActivityItems: [image])
        }
        
        stackView.addArrangedSubview(view)
    }
    
    private func addPixelBoardView() {
        let view = PixelBoardView(target: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(view.heightAnchor.constraint(equalToConstant: 400.0))
        view.didPanPiece = didPanPiece
        
        stackView.addArrangedSubview(view)
        
        pixelBoardView = view
    }
    
    private func addToolsView() {
        let view = ToolsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(view.heightAnchor.constraint(equalToConstant: height(percent: 71.7) - 400 - stackViewTopConstraint.constant))
        view.didTapBorderButton = { [weak self] in
            guard let self = self else { return }
            self.viewModel.shouldShowBorder = !self.viewModel.shouldShowBorder
            self.pixelBoardView.reload()
        }
        view.didTapUndoButton = { [weak self] in
            self?.viewModel.currentTool = .undo
            self?.viewModel.undo()
            self?.pixelBoardView.reload()
        }
        view.didTapResetButton = { [weak self] in
            self?.viewModel.currentTool = .reset
            self?.viewModel.reset()
            self?.pixelBoardView.reload()
        }
        view.didTapEraseButton = { [weak self] in
            self?.viewModel.currentTool = self?.viewModel.currentTool == .erase ? .none : .erase
        }
        
        stackView.addArrangedSubview(view)
        
        toolsView = view
    }
    
    private func addSeparateBarView() {
        let view = SeparateBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(view.heightAnchor.constraint(equalToConstant: height(percent: 5)))
        stackView.addArrangedSubview(view)
    }
    
    private func addColorsView() {
        let view = ColorsView()
        view.currentColor = currentColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(view.heightAnchor.constraint(equalToConstant: height(percent: 10.3)))
        view.didTapColorButton = { [weak self] (color) in
            self?.viewModel.currentTool = .drawing
            self?.currentColor = color
            self?.toolsView.eraseButtonToggleOff()
        }
        
        stackView.addArrangedSubview(view)
    }
    
    private func height(percent: CGFloat) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let stackViewTopConstraint = stackViewTopConstraint.constant
        return (screenHeight - stackViewTopConstraint) * percent / 100.0
    }
}

// MARK: - GestureRecognizer
extension MainViewController {
    // Tap Gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let cell = touch.view as? PixelCell {
            switch viewModel.currentTool {
            case .erase:
                cell.backgroundColor = .white
            default:
                cell.backgroundColor = currentColor
                if let indexPath = cell.indexPath {
                    viewModel.drawingCells[indexPath] = currentColor
                }
            }
            return true
        }
        return false
    }
    
    // Pan Gesture
    private func didPanPiece(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let pixelBoard = gestureRecognizer.view as? UICollectionView else { return }
        let point = gestureRecognizer.location(in: pixelBoard)
        let x = Int((point.x / 20.0).rounded(.up)) - 1
        let y = Int((point.y / 20.0).rounded(.up)) - 1
        guard x >= 0 && x < 20 else { return }
        guard y >= 0 && y < 20 else { return }
        
        let indexPath = IndexPath(item: x, section: y)
        guard let cell = pixelBoard.cellForItem(at: indexPath) as? PixelCell else { return }
        
        switch gestureRecognizer.state {
        case .began:
            switch viewModel.currentTool {
            case .erase:
                cell.backgroundColor = .white
            default:
                viewModel.currentTool = .drawing
                cell.backgroundColor = currentColor
                viewModel.drawingCells[indexPath] = currentColor
            }
        case .changed:
            switch viewModel.currentTool {
            case .drawing:
                cell.backgroundColor = currentColor
                viewModel.drawingCells[indexPath] = currentColor
            case .erase:
                cell.backgroundColor = .white
            default:
                break
            }
        case .cancelled, .ended:
            switch viewModel.currentTool {
            case .erase:
                break
            default:
                viewModel.currentTool = .none
                viewModel.storeDrawingCells()
            }
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PixelCell.self), for: indexPath) as? PixelCell else { return UICollectionViewCell() }
        let color = viewModel.color(for: indexPath)
        if viewModel.currentTool == .reset {
            viewModel.currentTool = .none
        }
        cell.configure(
            color: viewModel.currentTool != .reset && color != nil ? color! : .white,
            needBorder: viewModel.shouldShowBorder,
            indexPath: indexPath,
            debugMode: viewModel.showCellIndexInDebugMode
        )
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - Debug Mode
extension MainViewController: UIActionSheetDelegate {
    fileprivate func showDebugMeu() {
        let actionSheet = UIAlertController(title: "Debug Menu", message: nil, preferredStyle: .actionSheet)
        let showIndexAction = UIAlertAction(title: "Toggle Show Cell Index", style: .default) { [weak self] action in
            self?.toggleShowCellIndex()
        }
        actionSheet.addAction(showIndexAction)
        
        let exampleAction1 = UIAlertAction(title: "Example 1.", style: .default) { [weak self] action in
            self?.viewModel.loadExamplePixelMoji()
            self?.pixelBoardView.reload()
        }
        actionSheet.addAction(exampleAction1)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    private func toggleShowCellIndex() {
        viewModel.showCellIndexInDebugMode = !viewModel.showCellIndexInDebugMode
        pixelBoardView.reload()
    }
}

// MARK: - UIWindow
extension UIWindow {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            guard let mainVC = UIApplication.shared.topMostViewController() as? MainViewController else { return }
            mainVC.showDebugMeu()
        }
    }
}

extension UIApplication {
  func topMostViewController() -> UIViewController? {
    return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController?.topMostViewController()
  }
}
