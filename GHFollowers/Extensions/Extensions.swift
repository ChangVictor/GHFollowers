//
//  Extensions.swift
//  GHFollowers
//
//  Created by Victor Chang on 14/01/2024.
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

extension Date {

    func convertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
