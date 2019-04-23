//
//  AppRouter.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit

class AppRouter {
  
  func startScreen() -> UIViewController {
    let listViewController = ListRouter().build()
    let navigationController = UINavigationController()
    navigationController .viewControllers = [listViewController]
    return navigationController
  }
  
}

