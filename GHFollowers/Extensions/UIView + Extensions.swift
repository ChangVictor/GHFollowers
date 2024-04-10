//
//  UIView + Extensions.swift
//  GHFollowers
//
//  Created by Victor Chang on 10/04/2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubviews(view) }
    }
}
