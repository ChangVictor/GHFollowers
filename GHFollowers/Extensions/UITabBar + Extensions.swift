//
//  UITabBar + Extensions.swift
//  GHFollowers
//
//  Created by Victor Chang on 11/04/2024.
//

import UIKit

extension UITabBar {
    
    static func create() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .tertiarySystemBackground
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//        UITabBar.appearance().compactAppearance = tabBarAppearance
    }
}
