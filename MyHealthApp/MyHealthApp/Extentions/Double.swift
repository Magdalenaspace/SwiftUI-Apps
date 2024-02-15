//
//  Double.swift
//  MyHealthApp
//
//  Created by Magdalena Samuel on 11/25/23.
//

import Foundation

extension Double {
    func formattedStringWithCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
