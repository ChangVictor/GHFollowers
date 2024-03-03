//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Victor Chang on 03/03/2024.
//

import UIKit

class GFFollowersItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configItems()
    }
    
    private func configItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

}
