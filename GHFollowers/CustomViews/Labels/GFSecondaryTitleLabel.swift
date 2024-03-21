//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Victor Chang on 28/02/2024.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(size: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: size, weight: .medium)  
    }
    
    private func config() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
