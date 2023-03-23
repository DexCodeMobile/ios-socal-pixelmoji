//
//  UIViewControllerExtensions.swift
//  PixelArt
//
//  Created by Dexter Kim on 5/13/22.
//

import Foundation
import UIKit

// MARK: - Presents
extension UIViewController {
    // Share Sheet
    func presentActivityView(withActivityItems activityItems: [Any],
                             appActivities: [UIActivity]? = nil,
                             completionWithItemsHandler: ((UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void)? = nil) {
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: appActivities)
        activityVC.completionWithItemsHandler = completionWithItemsHandler
        present(activityVC, animated: true)
    }
}

// MARK: - Hierarchy
extension UIViewController {
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        return self.presentedViewController!.topMostViewController()
    }
}
