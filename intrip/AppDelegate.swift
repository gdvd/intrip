//
//  AppDelegate.swift
//  intrip
//
//  Created by Gilles David on 17/12/2021.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            self.window = UIWindow(frame: UIScreen.main.bounds)
                    window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                    window?.makeKeyAndVisible()
            return true
        }
}
