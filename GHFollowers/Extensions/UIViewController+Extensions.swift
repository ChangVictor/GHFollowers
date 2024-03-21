//
//  UIViewController+Extensions.swift
//  GHFollowers
//
//  Created by Victor Chang on 01/02/2024.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentSafariView(with url: URL){
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
    
    func presentGHAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
        }
    }
}
