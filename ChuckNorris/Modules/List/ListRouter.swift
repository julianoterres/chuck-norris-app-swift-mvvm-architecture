//
//  ListRouter.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit

class ListRouter: ListRouterProtocol {
  
  weak var viewController: ListViewController?
  
  func build() -> ListViewController {
    let viewController = ListViewController()
    let router = ListRouter()
    viewController.router = router
    viewController.searchViewController = SearchRouter().build()
    router.viewController = viewController
    return viewController
  }
  
}
