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
  let reloadRecentTags: Driver<Bool>
  
  init(didSearchbarAction: Observable<String>, didSelectTag: Observable<String>, service: ListService) {
    
    let tableHide = BehaviorRelay(value: false)
    let noResultFoundHide = BehaviorRelay(value: true)
    let recentTagsReload  = BehaviorRelay(value: true)
    var termSearch: String = ""
    
    hideTable = tableHide
      .startWith(false)
      .asDriver(onErrorJustReturn: false)
    
    reloadRecentTags = recentTagsReload
      .startWith(true)
      .asDriver(onErrorJustReturn: true)
    
    hideNoResultFound = noResultFoundHide
      .startWith(true)
      .asDriver(onErrorJustReturn: true)
    
    facts = Observable.merge(didSearchbarAction, didSelectTag)
      .filter { !$0.isEmpty }
      .do(onNext: { term in
        termSearch = term
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
            category: category,
            url: factApi.url ?? ""
          )
        })
      })
      .do(onNext: { factsView in
        if factsView.count > 0 {
          if var recentsTerms = UserDefaults.standard.object(forKey: "recentsTags") as? [String] {
            if !recentsTerms.contains(termSearch) {
              recentsTerms.append(termSearch)
              UserDefaults.standard.set(recentsTerms, forKey: "recentsTags")
            }
          } else {
            UserDefaults.standard.set([termSearch], forKey: "recentsTags")
          }
          recentTagsReload.accept(true)
        }
        let noResultFoundShow = (factsView.count > 0) ? true : false
        noResultFoundHide.accept(noResultFoundShow)
        tableHide.accept(false)
      })
      .asDriver(onErrorJustReturn: [])
    
  }
  
}
