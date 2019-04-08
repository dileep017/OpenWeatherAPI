//
//  OWCity.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

// MARK:- OWCity

public struct OWCity: Codable,Equatable {
    internal enum CodingKeys: String, CodingKey {
        case name = "name"
        case country = "country"
    }
    
    public var name: String?
    public var country: String?
    
    // MARK: - LifeCycle
    public init() {}
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
}
