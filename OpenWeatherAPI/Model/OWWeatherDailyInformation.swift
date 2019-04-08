//
//  OWWeatherDailyInformation.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 29/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

struct weatherDailyInformation {
    let dayIdentifier: DayIdentifier
    var forecasts: [OWInformationList]
    
    
    static func dailyForecast(forecasts: [OWInformationList]) -> [weatherDailyInformation] {
        
        // Ensure we have forecasts
        guard !forecasts.isEmpty else {
            return []
        }
        
        // Group all forecasts into days
        let calendar = Calendar.current
        var grouped: [DayIdentifier: [OWInformationList]] = [:]
        for forecast in forecasts {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss"
            guard let forecastDate = dateFormatter.date(from: forecast.dt_txt!) else {
                continue
            }
            // Get day identifier
            let comps = calendar.dateComponents([.year,.month,.day,.weekday], from: forecastDate)
            let dayIdentifier = DayIdentifier.fromComponents(components: comps)
            // Add to grouped
            var forecasts = grouped[dayIdentifier] ?? [OWInformationList]()
            forecasts.append(forecast)
            grouped[dayIdentifier] = forecasts
        }
        
        // Create daily forecast objects
        var dailyForecasts: [weatherDailyInformation] = []
        for (dayIdentifier, forecasts) in grouped {
            let sortedForecasts = forecasts.sorted(by: {$0.dt_txt! < $1.dt_txt!})
            let dailyForecast = weatherDailyInformation.init(dayIdentifier: dayIdentifier, forecasts: sortedForecasts)
            dailyForecasts.append(dailyForecast)
        }
        
        // Return sorted daily forecasts
        return dailyForecasts.sorted(by: {$0.dayIdentifier < $1.dayIdentifier})
    }
}
