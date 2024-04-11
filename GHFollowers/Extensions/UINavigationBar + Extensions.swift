//
//  UINavigationBar + Extensions.swift
//  GHFollowers
//
//  Created by Victor Chang on 11/04/2024.
//

import UIKit

// MARK: - extension to give navigationBar & tabBar a white background
extension UINavigationBar {
    
    static func create() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .tertiarySystemBackground
        appearance().standardAppearance = navBarAppearance
        appearance().scrollEdgeAppearance = navBarAppearance
        appearance().compactAppearance = navBarAppearance
    }
}
