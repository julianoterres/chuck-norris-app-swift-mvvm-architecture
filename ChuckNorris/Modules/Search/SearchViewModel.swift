//
//  SearchViewModel.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
  
  let categories: Driver<[String]>
  let recents: Driver<[String]>
  
  init(service: SearchService) {
    
    categories = service
      .fetchCategories()
      .map({ $0 })
      .asDriver(onErrorJustReturn: [])
    
    recents = service
      .fetchCategories()
      .map({ $0 })
      .asDriver(onErrorJustReturn: [])
    
  }
  
}
