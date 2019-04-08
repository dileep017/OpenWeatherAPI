//
//  WeatherRequest.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

struct weatherRequest: Request {

    private struct Keys {
        static let city = "id"
    }
    
    var endPoint = "forecast"
    var method: HTTPMethod = .get
    var parameters: [String: Any]?
    
    init(city: String? = nil) {
        var params: [String: Any] = [:]
        
        if let city = city {
            params[Keys.city] = city
        }
        
        parameters = params
    }
    
}
