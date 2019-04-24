//
//  ListService.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 23/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class ListService {
  
  var api: API!
  
  init(api: API) {
    self.api = api
  }
  
  func fetchFacts(term: String) -> Observable<FactsResultApi> {
    return RxAlamofire.requestData(.get, api.searchUrl(term: term)).map({ (response, data) in
      try! JSONDecoder().decode(FactsResultApi.self, from: data)
    })
  }
  
}
