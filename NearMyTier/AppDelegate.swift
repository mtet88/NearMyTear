//
//  AppDelegate.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 22.05.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let rootVC = NMTViewController.makeLocationPermissionViewController() else {
            print("Root VC not found")
            return true
        }
                
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }
}
