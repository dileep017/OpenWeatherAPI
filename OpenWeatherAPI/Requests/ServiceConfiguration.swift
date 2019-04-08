//
//  ServiceConfiguration.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

// MARK: - ServiceConfigurtion

/// Protocol that configures values used in a service call.
public protocol ServiceConfiguration {

    var id: String { get set }
    var appid: String { get set }
    
    var queryString: String { get }
}

//MARK:- ServiceConfigurable

public class ServiceConfigurable: ServiceConfiguration {
    
    public var id: String = "4887398"
    
    public var appid: String = "6e9ae62bd0f674988e8291f238b1cc3b"
    
    public var queryString: String {
        let query = "id=\(id)&appid=\(appid)"
        return query
    }
    
    public init() {}
    
    public static var shared: ServiceConfigurable = ServiceConfigurable()

}
