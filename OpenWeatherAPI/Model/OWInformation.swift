//
//  OWInformation.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

//MARK:- OWInformation

struct OWInformation: Equatable, Codable {
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case humidity = "humidity"
    }
    
    public var temp: Double?
    public var temp_min: Double?
    public var temp_max: Double?
    public var humidity: Int?
    
    
   
    // MARK: - LifeCycle
    public init() {}
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decode(Double.self, forKey: .temp)
        temp_min = try values.decode(Double.self, forKey: .temp_min)
        temp_max = try values.decode(Double.self, forKey: .temp_max)
        humidity = try values.decode(Int.self, forKey: .humidity)
    }
    
    public static func == (lhs: OWInformation, rhs: OWInformation) -> Bool {
        return lhs.temp == rhs.temp && lhs.temp_min == rhs.temp_min && lhs.temp_max == rhs.temp_max && lhs.humidity == rhs.humidity
    }
}
