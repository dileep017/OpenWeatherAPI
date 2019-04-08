//
//  ViewExtension.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 30/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground(ColorOne: UIColor, ColorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [ColorOne.cgColor, ColorTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
