//
//  OWWeather.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

public struct OWWeather: Equatable, Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    public var id: Int?
    public var main: String?
    public var description: String?
    public var icon: String?
    
    // MARK: - LifeCycle
    public init() {}
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        main = try values.decodeIfPresent(String.self, forKey: .main) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        icon = try values.decodeIfPresent(String.self, forKey: .icon) ?? ""
        
    }
    
    public static func == (lhs: OWWeather, rhs: OWWeather) -> Bool {
        return lhs.id == rhs.id && lhs.main == rhs.main && lhs.description == rhs.description && lhs.icon == rhs.icon
    }
}
