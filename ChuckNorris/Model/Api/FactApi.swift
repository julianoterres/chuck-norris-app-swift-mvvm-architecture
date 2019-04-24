//
//  FactApi.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 23/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import Foundation

struct FactApi: Codable {
  let category: [String]?
  let icon_url: String?
  let id: String?
  let url: String?
  let value: String?
}
