//
//  Extensions.swift
//  GHFollowers
//
//  Created by Victor Chang on 14/01/2024.
//

import UIKit

extension Date {

    func convertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
