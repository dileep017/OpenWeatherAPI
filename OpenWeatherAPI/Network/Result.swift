//
//  Result.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

/// Encapsulates whether the response of a request was successful or failed.
public enum Result<Value> {
    
    /// A successful request
    case success(Value)
    
    /// A failed request
    case failure(Error?)
    
    /// Returns the value if the result is a success.
    /// Otherwise returns nil
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the error value if the result is a failure.
    /// Otherwise returns nil
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
    /// Creates a success `Result` instance.
    public init(value: Value) {
        self = .success(value)
    }
    
    /// Creates a failure `Result` instance.
    public init(error: Error?) {
        self = .failure(error)
    }
    
}
