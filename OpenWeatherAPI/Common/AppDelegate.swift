//
//  AppDelegate.swift
//  OpenWeatherAPI
//
//  Created by dileep.kumar.gaddam on 26/03/19.
//  Copyright © 2019 dileep.kumar.gaddam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let networkService = NetworkService()
    private let jsonParsable: JSONParsable = JSONParser()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.setGradientBackground(ColorOne: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), ColorTwo: #colorLiteral(red: 0.4053153396, green: 0.664766252, blue: 0.8025251031, alpha: 1))
        makeCloudsOnBackground()
        
        let weatherViewModel = OWListViewModel.init(networkService: networkService, jsonParsable: jsonParsable)
        
        let weatherViewController = OWListViewController()
        weatherViewController.weatherDisplayable = weatherViewModel
        
        window?.rootViewController = weatherViewController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func makeCloudsOnBackground() {
        let bigCloudImageView = UIImageView(frame: CGRect(x: window!.frame.width / 2, y: 0, width: 350, height: 207))
        bigCloudImageView.image = UIImage(named: "cloud1")
        window?.addSubview(bigCloudImageView)
        
        UIView.animate(withDuration: 180,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: { [unowned self] in
                        bigCloudImageView.frame.origin.x -= ((self.window!.frame.width / 2) + bigCloudImageView.frame.width) })
        
        
        let smallCloudImageView = UIImageView(frame: CGRect(x: window!.frame.width / 2, y: 0, width: 270, height: 146))
        smallCloudImageView.image = UIImage(named: "cloud2")
        window?.addSubview(smallCloudImageView)
        
        UIView.animate(withDuration: 120,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: { [unowned self] in
                        smallCloudImageView.frame.origin.x -= ((self.window!.frame.width / 2) + smallCloudImageView.frame.width) })
    }
    
}

