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
    let router = ListRouter()
    let searchViewController =  SearchRouter().build()
    let service = ListService(api: api)
    
    let searchBarTextEvent = viewController.searchBar.rx.searchButtonClicked.withLatestFrom(viewController.searchBar.rx.text.orEmpty)
    let tagsSelectEvent = searchViewController.tagSelected.asObservable()
    
    
    viewController.searchViewController = searchViewController
    
    let viewModel = ListViewModel(didSearchbarAction: searchBarTextEvent, didSelectTag: tagsSelectEvent, service: service)
    
    viewController.viewModel = viewModel
    viewController.router = router
    router.viewController = viewController
    return viewController
  }
  
  func openShare(fact: FactView?) {
    guard let factSelected = fact else { return }
    let textToShare = [factSelected.url]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    viewController?.present(activityViewController, animated: true, completion: nil)
  }
  
}
