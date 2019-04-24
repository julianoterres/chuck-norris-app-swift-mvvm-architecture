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
    let api = API()
    let searchBarTextEvent = viewController.searchBar.rx.searchButtonClicked.withLatestFrom(viewController.searchBar.rx.text.orEmpty.asObservable())
    let service = ListService(api: api)
    let viewModel = ListViewModel(didSearchbarAction: searchBarTextEvent, service: service)
    let searchViewController =  SearchRouter().build()
    viewController.viewModel = viewModel
    viewController.searchViewController = searchViewController
    return viewController
  }
  
}
