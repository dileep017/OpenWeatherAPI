//
//  JSONError.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

enum JSONError: Int, Error {
    case noValue
    case mismatchedType
}
