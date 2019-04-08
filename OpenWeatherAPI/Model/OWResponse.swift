//
//  OWResponse.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

public typealias OWResponseResult = (_ result: Result<OWResponse>) -> Void

//MARK:- OWResponse
public struct OWResponse: Equatable, Codable {
    
    internal enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
    
    public var cod: String?
    public var cnt: Int?
    public var list: [OWInformationList] = []
    public var city: OWCity?
    
    //MARK:- LifeCycle
    
    public init(){}
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try values.decodeIfPresent(String.self, forKey: .cod) ?? ""
        cnt = try values.decode(Int.self, forKey: .cnt)
        list  = try values.decode(Array<OWInformationList>.self, forKey: .list)
        city = try values.decode(OWCity.self, forKey: .city)
    }
    
    public static func == (lhs: OWResponse, rhs: OWResponse) -> Bool {
        return lhs.cod == rhs.cod && lhs.cnt == rhs.cnt && lhs.list == rhs.list && lhs.city == rhs.city
    }
    
    
}
