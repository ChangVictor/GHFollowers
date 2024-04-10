//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Victor Chang on 03/03/2024.
//

import UIKit

protocol GFFollowersItemDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowersItemViewController: GFItemInfoViewController {
    
    weak var delegate: GFFollowersItemDelegate!
    
    init(user: User, delegate: GFFollowersItemDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configItems()
    }
    
    private func configItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

    override func actionButtonTapped() {
        guard user.followers != 0 else {
            presentGHAlertOnMainThread(title: "No followers", message: "This user has no followers", buttonTitle: "Done")
            return
        }
        
        delegate.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
}
