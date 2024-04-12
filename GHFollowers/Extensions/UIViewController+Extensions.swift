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
    
    func presentGHAlert(title: String, message: String, buttonTitle: String) {
        let alertViewController = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        present(alertViewController, animated: true)
    }
    
    func presentDefaultError() {
        let alertViewController = GFAlertViewController(title: "Something went wrong",
                                                        message: "Unable to compete task",
                                                        buttonTitle: "OK")
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        present(alertViewController, animated: true)
    }
}
