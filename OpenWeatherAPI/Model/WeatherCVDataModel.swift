//
//  WeatherCVDataModel.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 29/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

class WeatherCVDataModel {
    
    // MARK: - Properties
    var forecast = [weatherDailyInformation]()
    
    // MARK: - Initialization
    init(forecast: [weatherDailyInformation]) {
        self.forecast = forecast
    }
    
}
