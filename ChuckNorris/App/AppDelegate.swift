//
//  AppDelegate.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   callMainScreen()
    return true
  }
  
  func callMainScreen() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = AppRouter().startScreen()
    window?.makeKeyAndVisible()
  }

}

