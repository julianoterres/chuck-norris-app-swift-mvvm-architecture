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
  
  init(loadRecents: Observable<Bool>,service: SearchService) {
    
    categories = service
      .fetchCategories()
      .map({ $0 })
      .do(onNext: { (categories) in
        
      })
      .asDriver(onErrorJustReturn: [])
    
    recents = loadRecents
      .flatMapLatest({ (status) in
        service.fetchRecents()
      })
      .map({ $0 })
      .asDriver(onErrorJustReturn: [])
    
  }
  
}
