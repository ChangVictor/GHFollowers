//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Victor Chang on 14/01/2024.
//

import UIKit

class SearchViewController: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    
    var isUsernmaeEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)
        configLogoImageView()
        configTextField()
        configActionButton()
        createDismissKeyboardTapGesture()
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func pushFollowersViewController() {
        guard isUsernmaeEntered else {
            presentGHAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followersViewController = FollowersListViewController(username: usernameTextField.text!)
        followersViewController.username = usernameTextField.text
        followersViewController.title = usernameTextField.text
        navigationController?.pushViewController(followersViewController, animated: true)
    }
    
    func configLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceType.isiphoneSE || DeviceType.isiphone8Zoomed ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configTextField() {
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowersViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
