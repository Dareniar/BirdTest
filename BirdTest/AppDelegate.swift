//
//  AppDelegate.swift
//  BirdTest
//
//  Created by Danil Shchegol on 23.02.2020.
//  Copyright © 2020 Danil Shchegol. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
     var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let isNotFirstLoad = UserDefaults.standard.bool(forKey: "isNotFirstLoad")
        //if csv wasn't read then convert contents of it into Reakm objects
        if !isNotFirstLoad {
            CSVReader.shared.readBuildings(from: "buildings")
            UserDefaults.standard.set(true, forKey: "isNotFirstLoad")
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = MapViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

