//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Victor Chang on 21/02/2024.
//

import UIKit
import SafariServices

protocol UserInfoViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    var username: String!
    weak var delegate: UserInfoViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configScrollView()
        layoutUI()
        getUserInfo()
    }
        
    func configViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configUIElements(for: user) }
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
    
    func configUIElements(for user: User) {
        self.add(childViewController: GFRepoItemViewController(user: user, delegate: self), to: self.itemViewOne)
        self.add(childViewController: GFFollowersItemViewController(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.dateLabel.text = "(Github since \(user.createdAt.convertToMonthYearFormat()))"
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

extension UserInfoViewController: GFRepoItemDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGHAlertOnMainThread(title: "Invalid URL", message: "The url attached to his user is invalid", buttonTitle: "OK")
            return
        }
        presentSafariView(with: url)
    }
}

extension UserInfoViewController: GFFollowersItemDelegate {
    
    func didTapGetFollowers(for user: User) {
        // dismiss view
        // tell follower list screen the new user
        delegate.didRequestFollowers(for: user.login)
    }
}
