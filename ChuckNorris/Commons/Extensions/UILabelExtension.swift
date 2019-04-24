//
//  UILabelExtension.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 23/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit

extension UILabel {
  
  func setFontSizeText() {
    guard let textLabel = text else {
      self.font = .fontSmallText
      return
    }
    self.font = (textLabel.count >= 80) ? .fontSmallText : .fontBigText
  }
  
}
