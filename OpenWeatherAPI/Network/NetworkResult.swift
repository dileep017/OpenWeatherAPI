//
//  NetworkResult.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation

/// Result for a network request.
public typealias NetworkResult = ((_ result: Result<[String: Any]>) -> Void)

