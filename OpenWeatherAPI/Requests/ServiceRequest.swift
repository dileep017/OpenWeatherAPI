//
//  ServiceRequest.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

//MARK:- Request

public protocol Request {
    
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var endPoint: String { get }
    var parameters: [String:Any]? { get }
}


public enum HTTPMethod: String {
    case get
    case post
}

extension Request {
    
    /// Defaults to `GET`
    public var method: HTTPMethod {
        return .get
    }
    
    // Base url
    public var baseUrl: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    /// Defaults to `nil`
    public var parameters: [String: Any]? {
        return nil
    }

}


public protocol ServiceRequest {
    /// Attempts to make a network call based on the requset type.
    ///
    /// - Parameters:
    ///   - request: A `Service.Request` to make a network call
    ///   - completionHandler: An, optional, network handler invoked on a successful or failed network request
    ///
    func request(_ request: Request,
                 completionHandler: NetworkResult?)
}
