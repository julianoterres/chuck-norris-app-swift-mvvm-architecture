//
//  Api.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 23/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import Foundation

class API: APIProtocol {
  
  private let baseUlr = "https://api.chucknorris.io/jokes/"
  
  func searchUrl(term: String) -> URL {
    return URL(string: baseUlr + "search?query=" + term)!
  }
  
  func categories() -> URL {
    return URL(string: baseUlr + "categories")!
  }
  
}

