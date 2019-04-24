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
    if let categories = UserDefaults.standard.object(forKey: "firstSessionSend") as? Variable<[String]> {
      return categories.asObservable()
    } else {
      return RxAlamofire.requestData(.get, api.categories()).map({ (response, data) in
        try! JSONDecoder().decode([String].self, from: data)
      })
    }
  }
  
}
