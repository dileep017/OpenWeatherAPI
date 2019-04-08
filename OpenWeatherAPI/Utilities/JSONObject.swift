//
//  JSONObject.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

// MARK:- JSONObject

open class JSONObject: NSObject {
    fileprivate var dictionary: [String: Any]
    
    public required init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        super.init()
    }
    
    open func retrieveValueForKey<A>(_ key: String) throws -> A {
        if let value = self.dictionary[key] {
            if let typedValue = value as? A {
                return typedValue
            } else {
                throw JSONError.mismatchedType
            }
        } else {
            throw JSONError.noValue
        }
    }
    
    open func retrieveOptionalValueForKey<A>(_ key: String) throws -> A? {
        if let value = self.dictionary[key] {
            if let typedValue = value as? A {
                return typedValue
            } else {
                throw JSONError.mismatchedType
            }
        }
        return nil
    }
    
    open func retrieveValueForKey<A>(_ key: String, defaultValue: A) -> A {
        return self.dictionary[key] as? A ?? defaultValue
    }
    
}
