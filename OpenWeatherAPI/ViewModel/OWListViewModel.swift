//
//  OWListViewModel.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

class OWListViewModel {
    
    // MARK: - Properties
    var networkService: NetworkService
    var weatherResponse: OWResponse?
    var jsonParsable: JSONParsable
    var informationList: [OWInformationList] = []
    
    // MARK: - Initialization
    init(networkService: NetworkService,jsonParsable: JSONParsable) {
        self.networkService = networkService
        self.jsonParsable = jsonParsable
    }
    
    func fetchData(completion: ((Result<OWResponse>) -> Void)?) {
        let requ = weatherRequest.init(city: "bangalore")
        networkService.request(requ, completionHandler: { [weak self] (result: Result<[String: Any]>) in
            DispatchQueue.main.async { [weak self] in
                guard self != nil else { return }
                switch result {
                case .success(let data):
                    let optionData: [String:Any] = data
                    let response: OWResponse = self?.jsonParsable.decode(dictionary: optionData) ?? OWResponse()
                    self?.informationList = response.list
                    completion?(Result(value: response))
                case .failure:
                    break
                }
            }
        })
    }
   
}
