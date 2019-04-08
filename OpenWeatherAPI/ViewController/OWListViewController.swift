//
//  OWListViewController.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import UIKit

// Delegates
protocol weatherCVListDelegate {
    func reloadView()
}

protocol OWListViewControllerDelegate {
    func reloadView()
}


class OWListViewController: UIViewController {
    
    // MARK: - Properties
    let cellId = "informationCell"
    var weatherDisplayable: OWListViewModel?
    var delegate: weatherCVListDelegate?
    var networkService: NetworkService?
    var weatherDailyForecast: [weatherDailyInformation]?
    
    // MARK: - UIElements
    var activityIndicatorBackgroundView: UIView!
    var activityIndicatorView: UIActivityIndicatorView!
    var weatherTableView: UITableView!
    var cityLabel: UILabel!
    var segmentedControl : UISegmentedControl!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        weatherDisplayable?.fetchData(completion: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let service):
                    self.weatherDisplayable?.weatherResponse = service
                    if (self.weatherDisplayable?.weatherResponse?.list.count)! > 0 {
                        self.weatherDailyForecast = weatherDailyInformation.dailyForecast(forecasts: self.weatherDisplayable?.weatherResponse?.list ?? [])
                        self.cityLabel.text = self.weatherDisplayable?.weatherResponse?.city?.name
                        self.weatherTableView.reloadData()
                   }
                case .failure:
                    break
                }
            }
        })
        makeSegmentedView()
        makeTitleView()
        makeWeatherTableView()
        makeRefreshActivityIndicator()
        
    }

}

extension OWListViewController: OWListViewControllerDelegate {
    
    func makeSegmentedView()  {
        segmentedControl = UISegmentedControl.init(items: ["Live","Fixed"])
        segmentedControl.setTitle("Live", forSegmentAt: 0)
        segmentedControl.setTitle("Fixed", forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.frame = CGRect.init(x: 140, y: 40, width: 100, height: 40)
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .white
        
        // Add target action method
        segmentedControl.addTarget(self, action: #selector(updateUI), for: .valueChanged)
        
        self.view.addSubview(segmentedControl)
    }
    
    // MARK:- Updating UI
   @objc func updateUI()  {
    switch segmentedControl.selectedSegmentIndex {
    case 0:
        self.reloadView()
    case 1:
        let resp = self.loadDataFromJSON(filename: "Response")
        self.reloadViewWithLocalJSON(response: resp ?? OWResponse())
    default:
        break
    }
    }
    
    func loadDataFromJSON(filename fileName: String) -> OWResponse? {
             let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                do {
                    let fileExists = FileManager().fileExists(atPath: fileUrl.path)
                    if fileExists {
                        let filepath = fileUrl.appendingPathComponent(fileName+".json")
                        let data = try Data.init(contentsOf: filepath)
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(OWResponse.self, from: data)
                        return jsonData
                    }
                } catch {
                    print("error:\(error)")
                }
            return nil
    }
    
    func makeRefreshActivityIndicator() {
        activityIndicatorBackgroundView = UIView()
        activityIndicatorBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorBackgroundView.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
        activityIndicatorBackgroundView.layer.cornerRadius = 15
        activityIndicatorBackgroundView.isHidden = true
        
        view.addSubview(activityIndicatorBackgroundView)
        
        let activityIndicatorBackgroundViewConstraints = [
            activityIndicatorBackgroundView.centerYAnchor.constraint(equalTo: weatherTableView.centerYAnchor),
            activityIndicatorBackgroundView.centerXAnchor.constraint(equalTo: weatherTableView.centerXAnchor),
            activityIndicatorBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            activityIndicatorBackgroundView.heightAnchor.constraint(equalTo: activityIndicatorBackgroundView.widthAnchor)]
        NSLayoutConstraint.activate(activityIndicatorBackgroundViewConstraints)
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.tintColor = .gray
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = true
        
        activityIndicatorBackgroundView.addSubview(activityIndicatorView)
        
        let activityIndicatorViewConstraints = [
            activityIndicatorView.centerYAnchor.constraint(equalTo: activityIndicatorBackgroundView.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: activityIndicatorBackgroundView.centerXAnchor)]
        NSLayoutConstraint.activate(activityIndicatorViewConstraints)
    }
    
    func makeTitleView()  {
        cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textColor = .black
        cityLabel.font = .systemFont(ofSize: 30)
        cityLabel.textAlignment = .center
        
        view.addSubview(cityLabel)
        let titleViewConstraints = [
            cityLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10.0),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        NSLayoutConstraint.activate(titleViewConstraints)
    }
    
    func makeWeatherTableView() {
        weatherTableView = UITableView()
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherTableView.separatorStyle = .none
        weatherTableView.showsVerticalScrollIndicator = false
        weatherTableView.backgroundColor = .clear
        weatherTableView.allowsSelection = false
        
        self.view.addSubview(weatherTableView)
        
        weatherTableView.register(OWInfromationCell.self, forCellReuseIdentifier: cellId)
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        let weatherForecastOnDayTableViewConstraints = [
            weatherTableView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        NSLayoutConstraint.activate(weatherForecastOnDayTableViewConstraints)
    }
    
    // MARK:- Reloading the views based on the response
    func reloadView() {
        activityIndicatorBackgroundView.isHidden = false
        activityIndicatorView.isHidden = false
        
        weatherDisplayable?.fetchData(completion: { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let service):
                    self.weatherDisplayable?.weatherResponse = service
                    if (self.weatherDisplayable?.weatherResponse?.list.count)! > 0 {
                        self.cityLabel.text = self.weatherDisplayable?.weatherResponse?.city?.name
                        self.weatherDailyForecast = weatherDailyInformation.dailyForecast(forecasts: self.weatherDisplayable?.weatherResponse?.list ?? [])
                    }
                   
                    self.weatherTableView.reloadData()
                    self.activityIndicatorBackgroundView.isHidden = true
                    self.activityIndicatorView.isHidden = true
                    self.delegate?.reloadView()
                case .failure:
                    break
                }
            }
        })
    }
    
    //MARK: - Reloading view in offline mode
    func reloadViewWithLocalJSON(response: OWResponse) {
        self.weatherDisplayable?.weatherResponse = response
        if (self.weatherDisplayable?.weatherResponse?.list.count)! > 0 {
            self.cityLabel.text = self.weatherDisplayable?.weatherResponse?.city?.name
            self.weatherDailyForecast = weatherDailyInformation.dailyForecast(forecasts: self.weatherDisplayable?.weatherResponse?.list ?? [])
        }
        
        self.weatherTableView.reloadData()
        self.activityIndicatorBackgroundView.isHidden = true
        self.activityIndicatorView.isHidden = true
        self.delegate?.reloadView()
    }
    
    
}

// MARK:- TableView Delegate and DataSoruce methods
extension OWListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let sectionsCount = weatherDailyInformation.dailyForecast(forecasts: self.weatherDisplayable?.weatherResponse?.list ?? [])
        
        if sectionsCount.count > 0 {
            return sectionsCount.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 150, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: weatherDailyForecast?[section].dayIdentifier.date() ?? Date())
        
        let label = UILabel()
        label.frame = CGRect.init(x: 145, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = dateString
        label.font = .systemFont(ofSize: 20)
        label.textColor = .brown
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 30.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OWInfromationCell
        cell.weatherCollectionViewDataModel = WeatherCVDataModel.init(forecast:weatherDailyForecast ?? [])
        cell.weatherViewController = self
        cell.weatherViewController.delegate = cell
        if (weatherDailyForecast?.count)! > 0 {
            return cell.madeWithModelOf((weatherDailyForecast?[indexPath.section])!)
        } else {
            return cell
        }
    }

}

