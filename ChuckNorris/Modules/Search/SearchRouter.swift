//
//  SearchRouter.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit

class SearchRouter {
  
  func build() -> SearchViewController {
    let viewController = SearchViewController()
    let api = API()
    let service = SearchService(api: api)
    let viewModel = SearchViewModel(service: service)
    viewController.viewModel = viewModel
    return viewController
  }
  
}
