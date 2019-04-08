//
//  JSONParser.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

// MARK: - JSONParsable

public protocol JSONParsable {
    
    func decode<T: Codable>(dictionary: [String: Any]) -> T?
    func decode<T: Codable>(dictionaries: [[String: Any]]) -> [T]
    
    func encode<T: Encodable>(encodable: T) -> Data?
    func encode<T: Encodable>(encodables: [T]) -> [Data]
    
    func jsonObject<T: Encodable>(encodable: T) -> [String : Any]?
    
}

// MARK: - JSONParser

public class JSONParser: JSONParsable {
    
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    public init() {}
    
    public func decode<T: Codable>(dictionary: [String: Any]) -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let value = try JSONParser.decoder.decode(T.self, from: data)
            return value
        } catch {
            print("Could not parse \(String(describing: T.self)) data: \(dictionary) with ERROR: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func decode<T: Codable>(dictionaries: [[String: Any]]) -> [T] {
        return dictionaries.compactMap { (dict) -> T? in
            return decode(dictionary: dict)
        }
    }
    
    public func encode<T: Encodable>(encodable: T) -> Data? {
        do {
            return try JSONParser.encoder.encode(encodable)
        } catch {
            return nil
        }
    }
    
    public func encode<T: Encodable>(encodables: [T]) -> [Data] {
        return encodables.compactMap({ encode(encodable: $0) })
    }
    
    public func jsonObject<T: Encodable>(encodable: T) -> [String : Any]? {
        do {
            let data = try JSONParser.encoder.encode(encodable)
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
        } catch {
            return nil
        }
    }
    
}
