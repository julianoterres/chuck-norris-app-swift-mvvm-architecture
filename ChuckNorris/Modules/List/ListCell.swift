//
//  ListCell.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 23/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
  
  let container = UIView()
  let labelText = UILabel()
  let labelCategory = UILabel()
  let buttonShare = UIButton()
  
  static let identifier = "ListCell"
  var fact: Fact?
  
  func setup(data: Fact) {
    fact = data
    addContainer()
    addTLabelText()
    addTLabelCategory()
    addButtonShare()
  }
  
  func addContainer() {
    contentView.addSubview(container)
    container.addConstraint(attribute: .top, alignElement: contentView, alignElementAttribute: .top, constant: 20)
    container.addConstraint(attribute: .right, alignElement: contentView, alignElementAttribute: .right, constant: 20)
    container.addConstraint(attribute: .left, alignElement: contentView, alignElementAttribute: .left, constant: 20)
    container.addConstraint(attribute: .bottom, alignElement: contentView, alignElementAttribute: .bottom, constant: 20)
  }
  
  func addTLabelText() {
    container.addSubview(labelText)
//    labelText.text = fact?.name ?? ""
    labelText.numberOfLines = 0
    labelText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    labelText.addConstraint(attribute: .top, alignElement: container, alignElementAttribute: .top, constant: 0)
    labelText.addConstraint(attribute: .right, alignElement: container, alignElementAttribute: .right, constant: 0)
    labelText.addConstraint(attribute: .left, alignElement: container, alignElementAttribute: .left, constant: 0)
  }
  
  func addTLabelCategory() {
    container.addSubview(labelCategory)
    labelCategory.text = "Category"
    labelCategory.textColor = .white
    labelCategory.layer.cornerRadius = 5
    labelCategory.backgroundColor = .black
    labelCategory.addConstraint(attribute: .top, alignElement: labelText, alignElementAttribute: .bottom, constant: 10)
    labelCategory.addConstraint(attribute: .left, alignElement: container, alignElementAttribute: .left, constant: 0)
    labelCategory.addConstraint(attribute: .bottom, alignElement: container, alignElementAttribute: .bottom, constant: 0)
  }
  
  func addButtonShare() {
    container.addSubview(buttonShare)
    buttonShare.setImage(UIImage(named: "icon_share")?.withRenderingMode(.alwaysTemplate), for: .normal)
    buttonShare.tintColor = .blue
    buttonShare.addConstraint(attribute: .right, alignElement: container, alignElementAttribute: .right, constant: 0)
    buttonShare.addConstraint(attribute: .height, alignElement: nil, alignElementAttribute: .notAnAttribute, constant: 30)
    buttonShare.addConstraint(attribute: .width, alignElement: nil, alignElementAttribute: .notAnAttribute, constant: 30)
    buttonShare.addConstraint(attribute: .centerY, alignElement: labelCategory, alignElementAttribute: .centerY, constant: 0)
  }
  
}
