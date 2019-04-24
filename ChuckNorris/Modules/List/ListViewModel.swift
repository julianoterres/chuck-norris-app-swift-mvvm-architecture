//
//  ListViewModel.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
  
  let facts: Driver<[FactView]>
  let hideTable: Driver<Bool>
  let hideNoResultFound: Driver<Bool>
  
  init(didSearchbarAction: Observable<String>, service: ListService) {
    
    let tableHide = BehaviorRelay(value: false)
    let noResultFoundHide = BehaviorRelay(value: true)
    
    hideTable = tableHide
      .startWith(false)
      .asDriver(onErrorJustReturn: false)
    
    hideNoResultFound = noResultFoundHide
      .startWith(true)
      .asDriver(onErrorJustReturn: true)
    
    facts = didSearchbarAction
      .do(onNext: { _ in
        tableHide.accept(true)
        noResultFoundHide.accept(true)
      })
      .flatMapLatest({ (term) in
        service.fetchFacts(term: term)
      })
      .map({
        $0.result.map({ factApi -> FactView in
          var category = "Uncategorized"
          if let categories = factApi.category {
            category = categories.joined(separator: " - ")
          }
          return FactView(
            text: factApi.value ?? "",
            category: category
          )
        })
      })
      .do(onNext: { factsView in
        let noResultFoundShow = (factsView.count > 0) ? true : false
        noResultFoundHide.accept(noResultFoundShow)
        tableHide.accept(false)
      })
      .asDriver(onErrorJustReturn: [])
    
  }
  
}
