//
//  ListProtocols.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit

protocol ListRouterProtocol {
  var viewController: ListViewController? { get set }
  func build() -> ListViewController
  func openShare(fact: FactView?)
}
