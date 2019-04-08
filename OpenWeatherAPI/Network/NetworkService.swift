//
//  NetworkService.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

//MARK:- NetworkService

public class NetworkService: ServiceRequest {
    
    public static var shared = NetworkService()
    public var serviceConfiguration: ServiceConfiguration = ServiceConfigurable.shared
    
    public func request(_ request: Request, completionHandler: NetworkResult?) {
        let baseUrlString = request.baseUrl
        let baseString = makeURLString(baseUrlString, endpoint: request.endPoint)
        let urlString = appendQueryString(baseString)
        let url = URL.init(string: urlString)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: URLRequest(url: url!))
        { (data, response, error) -> Void in
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    self.saveDataToLocal(weatherLocalResponse: json)
                    if let data = json as? [String: Any] {
                        completionHandler?(Result(value: data))
                    } else {
                        completionHandler?(Result(error: error))
                    }
                } catch {
                    let error = NetworkError.notsuccessful(statusCode: response.statusCode,
                                                           nestedError: error)
                    completionHandler?(Result(error: error))
                }
                
            }
           
        }
        task.resume()
        
    }
    
    func makeURLString(_ baseURLString: String, endpoint: String) -> String {
        return "\(baseURLString)\(endpoint)"
    }
    
    //MARK:- Saving Data Locally
    
    func saveDataToLocal(weatherLocalResponse: Any) {
        if let response = weatherLocalResponse as? Any {
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("Response.json")
                try? data.write(to: fileUrl)
            } catch {
                
            }
        }
    }
   
}



extension NetworkService {

    func appendQueryString(_ urlString: String) -> String {
        let queryString = makeQueryString()
        if queryString.isEmpty {
            return urlString
        }
        return "\(urlString)?\(queryString)"
    }
    
    func makeQueryString() -> String {
        return serviceConfiguration.queryString
    }

    
}


public enum NetworkError: Error {
    case notsuccessful(statusCode: Int, nestedError: Error?)
}
