//
//  Date.swift
//  MyHealthApp
//
//  Created by Magdalena Samuel on 11/25/23.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    static var startOfWeek: Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        
        return calendar.date(from: components)
    }
    
    static var oneMonthAgo: Date {
        let calendar = Calendar.current
        //method of the Calendar class to calculate a date representing one month ago from the current date 
        let oneMonth = calendar.date(byAdding: .month, value: -1, to: Date())
        return calendar.startOfDay(for: oneMonth!)
    }
}
