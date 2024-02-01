//
//  FollowersListViewController.swift
//  GHFollowers
//
//  Created by Victor Chang on 15/01/2024.
//

import UIKit

class FollowersListViewController: UIViewController {
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
