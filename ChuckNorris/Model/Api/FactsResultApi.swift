//
//  FactsResultApi.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 23/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import Foundation

struct FactsResultApi: Codable {
  let total: Int
  let result: [FactApi]
}
