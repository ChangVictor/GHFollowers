//
//  UserInfoVIewController.swift
//  GHFollowers
//
//  Created by Victor Chang on 21/02/2024.
//

import UIKit

class UserInfoVIewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
