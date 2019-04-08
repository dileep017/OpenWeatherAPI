//
//  DayIdentifier.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 29/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

struct DayIdentifier: Hashable, Equatable, Comparable {
    
    let year: Int
    let month: Int
    let day: Int
    
    /// Returns int in format yyyymmdd
    var rawValue: Int {
        return year * 10000 + month * 100 + day
    }

    static func fromComponents(components: DateComponents) -> DayIdentifier {
        return DayIdentifier(year: components.year!, month: components.month!, day: components.day!)
    }
    
    func dateComponents() -> DateComponents {
        var c = DateComponents()
        c.year = year
        c.month = month
        c.day = day
        return c
    }
    
    func date() -> Date? {
        return Calendar.current.date(from: dateComponents())
    }
    
    var hashValue: Int {
        return rawValue
    }
    
}


// MARK: - Equatable

func ==(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

// MARK: - Comparable

func <(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

func >(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue > rhs.rawValue
}

func <=(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue <= rhs.rawValue
}

func >=(lhs: DayIdentifier, rhs: DayIdentifier) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}
