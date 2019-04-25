//
//  SearchService.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 23/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class SearchService {
  
  var api: API!
  
  init(api: API) {
    self.api = api
  }
  
  func fetchCategories() -> Observable<[String]> {
    if let categories = UserDefaults.standard.object(forKey: "categorieTags") as? [String] {
      return Observable.create({ observable -> Disposable in
        observable.onNext(categories)
        return Disposables.create()
      })
    } else {
      return RxAlamofire.requestData(.get, self.api.categories()).map({ (response, data) in
        try! JSONDecoder().decode([String].self, from: data)
      }).map({ (categories) -> [String] in
        UserDefaults.standard.set(categories, forKey: "categorieTags")
        return categories
      })
    } 
  }
  
  func fetchRecents() -> Observable<[String]> {
    return Observable.create({ observable -> Disposable in
      if let recentsTags = UserDefaults.standard.object(forKey: "recentsTags") as? [String] {
        observable.onNext(recentsTags)
      }
      return Disposables.create()
    })
  }
  
}
