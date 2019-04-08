//
//  OWInformationDataCell.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 27/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation
import UIKit


class OWInformationDataCell: UICollectionViewCell {
    
    // MARK: - Properties
    var weatherViewController: OWListViewController!
    
    // MARK: - UI elements
  
    var titleView: UIStackView!
    var timeLabel: UILabel!
    var tempLabel: UILabel!
    var minTempView: UIStackView!
    var minTemp: UILabel!
    var maxTemp: UILabel!
    var weatherDescription: UILabel!
    var weatherIcon: UIImageView!
    var minTempTextLabel: UILabel!
    var maxTempTextLabel: UILabel!
    var maxTempView: UIStackView!
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeTitleView()
        makeTimeLabel()
        makeTempLabel()
        makeWeatherImageView()
        makeMinTempStackView()
        makeMaxTempStackView()
        makeMinTempLabels()
        makeMaxTempLabels()
        makeWeatherLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK:- Preparing Data cell
extension OWInformationDataCell {
    
    func makeWithModelOf(_ weather: OWInformationList) -> OWInformationDataCell {
        minTemp.text = String(format: "%.0f", (weather.main?.temp_min)! - Constants.Kelvin) + "°C"
        maxTemp.text = String(format: "%.0f", (weather.main?.temp_max)! - Constants.Kelvin)  + "°C"
        minTempTextLabel.text = Constants.minTemp
        maxTempTextLabel.text = Constants.maxTemp
        let imageName = weather.weather.first?.icon ?? ""
        weatherIcon.image = UIImage.init(named: imageName)
        weatherDescription.text = String(weather.weather.first?.main ?? "")
        let dateinUnix = weather.dt ?? 0.0
        let date = Date.init(timeIntervalSince1970: dateinUnix)
        let dateFormatter = DateFormatter()
        //Keeping it for GMT, since default date formatter takes system locale time zone
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.timeStyle = .short
        timeLabel.text = dateFormatter.string(from: date) + "/"
        tempLabel.text = String(format: "%.0f", (weather.main?.temp)! - Constants.Kelvin) + "°C"
        return self
    }
    
    
    func downloadImage() {
        
    }
    
    // Title View
    func makeTitleView() {
        titleView = UIStackView()
        titleView.distribution = .fillEqually
        titleView.spacing = 4
        titleView.axis = .horizontal
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)

        let titleViewConstraints = [titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
                                    titleView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
                                    titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8.0)]
        NSLayoutConstraint.activate(titleViewConstraints)
    }

    func makeWeatherImageView() {
        weatherIcon = UIImageView()
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.image = UIImage(named: "02d")

        self.addSubview(weatherIcon)

        let weatherImageViewConstraints = [
            weatherIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherIcon.heightAnchor.constraint(equalToConstant: 50.0),
            weatherIcon.widthAnchor.constraint(equalToConstant: 50.0),
            weatherIcon.topAnchor.constraint(equalTo: titleView.bottomAnchor)]
        NSLayoutConstraint.activate(weatherImageViewConstraints)
    }

    func makeMinTempStackView() {
        minTempView = UIStackView()
        minTempView.distribution = .fillEqually
        minTempView.spacing = 4
        minTempView.axis = .vertical
        minTempView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(minTempView)

        let minTempStackViewConstraints = [
            minTempView.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor),
            minTempView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0)]
        NSLayoutConstraint.activate(minTempStackViewConstraints)
    }
    
    func makeMaxTempStackView() {
        maxTempView = UIStackView()
        maxTempView.distribution = .fillEqually
        maxTempView.spacing = 4
        maxTempView.axis = .vertical
        maxTempView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(maxTempView)
        
        let maxTempStackViewConstraints = [
            maxTempView.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor),
            maxTempView.leadingAnchor.constraint(equalTo: minTempView.trailingAnchor, constant: 8.0),
            maxTempView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8.0)]
        NSLayoutConstraint.activate(maxTempStackViewConstraints)
    }

    func makeMinTempLabels() {
        minTempTextLabel = UILabel()
        minTempTextLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempTextLabel.textColor = .cyan
        minTempTextLabel.textAlignment = .center

        minTempView.addArrangedSubview(minTempTextLabel)

        minTemp = UILabel()
        minTemp.translatesAutoresizingMaskIntoConstraints = false
        minTemp.textColor = .white
        minTemp.textAlignment = .center
        minTemp.text = "--"

        minTempView.addArrangedSubview(minTemp)
    }

    
    func makeMaxTempLabels() {
        maxTempTextLabel = UILabel()
        maxTempTextLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempTextLabel.textColor = .red
        maxTempTextLabel.textAlignment = .center
        
        maxTempView.addArrangedSubview(maxTempTextLabel)
        
        maxTemp = UILabel()
        maxTemp.translatesAutoresizingMaskIntoConstraints = false
        maxTemp.textColor = .white
        maxTemp.textAlignment = .center
        maxTemp.text = "--"
        
        maxTempView.addArrangedSubview(maxTemp)
    }

    func  makeWeatherLabel() {
        weatherDescription = UILabel()
        weatherDescription.textAlignment = .center
        weatherDescription.font = .systemFont(ofSize: 20)
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.textColor = .white
        weatherDescription.layer.shadowOpacity = 0.4
        weatherDescription.layer.shadowOffset = CGSize(width: 0, height: 0)
        addSubview(weatherDescription)
        
        let weatherLabelConstraints = [
            weatherDescription.topAnchor.constraint(equalTo: bottomAnchor, constant: -40.0),
            weatherDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            weatherDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8.0)]
        NSLayoutConstraint.activate(weatherLabelConstraints)
        
    }
// Title View labels
    func makeTimeLabel()  {
        timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 20)
        timeLabel.textAlignment = .center
        timeLabel.lineBreakMode = .byWordWrapping
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textColor = .white
        timeLabel.layer.shadowOpacity = 0.4
        timeLabel.layer.shadowOffset = CGSize(width: 0, height: 0)

        titleView.addArrangedSubview(timeLabel)
    }

    func makeTempLabel(){
        tempLabel = UILabel()
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.textAlignment = .left
        tempLabel.font = .systemFont(ofSize: 20)
        tempLabel.textColor = .white
        tempLabel.layer.shadowOpacity = 0.4
        tempLabel.layer.shadowOffset = CGSize(width: 0, height: 0)

        titleView.addArrangedSubview(tempLabel)
    }
    
    
    
}

