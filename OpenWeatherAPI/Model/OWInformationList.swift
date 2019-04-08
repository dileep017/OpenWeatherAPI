//
//  OWInformationList.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

// MARK:- OWInfromationList
public struct OWInformationList: Equatable, Codable {

    private enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case dt_txt = "dt_txt"
    }

    public var dt: Double?
    internal var main: OWInformation?
    public var weather: [OWWeather] = []
    public var dt_txt: String?


    // MARK: - LifeCycle
    public init() {}

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decodeIfPresent(Double.self, forKey: .dt)
        main = try values.decodeIfPresent(OWInformation.self, forKey: .main)
        weather = try values.decodeIfPresent(Array<OWWeather>.self, forKey: .weather) ?? []
        dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt)
    }
    
    public static func == (lhs: OWInformationList, rhs: OWInformationList) -> Bool {
        return lhs.dt == rhs.dt && lhs.main == rhs.main && lhs.weather == rhs.weather && lhs.dt_txt == rhs.dt_txt
    }
}

