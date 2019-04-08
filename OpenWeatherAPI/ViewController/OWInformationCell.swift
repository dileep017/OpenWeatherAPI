//
//  OWInformationCell.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 27/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import Foundation
import UIKit

class OWInfromationCell: UITableViewCell {
    
    // MARK: - Properties
    let cellId = "informationDataCell"
    var weatherViewController: OWListViewController!
    var weatherCollectionViewDataModel: WeatherCVDataModel!
    
    // MARK: - UI elements
    var hourlyInformationCollectionView: UICollectionView!
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        makeSwipeCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- Collection View Delegate

extension OWInfromationCell: weatherCVListDelegate {
    
    func makeWithWeatherModelOf(_ forecast: OWInformationList) -> OWInfromationCell {
        return self
    }
    
    func makeSwipeCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.itemSize = CGSize.init(width: 180, height: 180)
        
        hourlyInformationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        hourlyInformationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyInformationCollectionView.backgroundColor = .clear
        hourlyInformationCollectionView.isPagingEnabled = true
        hourlyInformationCollectionView.showsHorizontalScrollIndicator = false
        hourlyInformationCollectionView.allowsSelection = false
        
        self.contentView.addSubview(hourlyInformationCollectionView)
        
        hourlyInformationCollectionView.register(OWInformationDataCell.self, forCellWithReuseIdentifier: cellId)
        
        hourlyInformationCollectionView.delegate = self
        hourlyInformationCollectionView.dataSource = self
        
        let swipeCollectionViewConstraints = [
            hourlyInformationCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourlyInformationCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hourlyInformationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourlyInformationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)]
        NSLayoutConstraint.activate(swipeCollectionViewConstraints)
    }
    
    func reloadView() {
        hourlyInformationCollectionView.reloadData()
    }
    
}

// MARK:- Preparing data for Cell
extension OWInfromationCell {
    func madeWithModelOf(_ weather: weatherDailyInformation) -> OWInfromationCell {
        self.weatherCollectionViewDataModel.forecast = [weather]
        return self
    }
}

// MARK:- Delegates for Collection View
extension OWInfromationCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let forecast = self.weatherCollectionViewDataModel.forecast
        if forecast.count > 0 {
            let forecasts = self.weatherCollectionViewDataModel.forecast[section].forecasts
            return forecasts.count
        } else {
           return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourlyInformationCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OWInformationDataCell
        cell.layer.addBorder(edge: .right, color: .gray, thickness: 0.5)
        let weather = weatherCollectionViewDataModel.forecast[0].forecasts[indexPath.row]
        return cell.makeWithModelOf(weather)
    }

    
}
