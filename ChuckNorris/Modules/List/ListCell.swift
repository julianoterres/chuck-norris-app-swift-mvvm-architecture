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
  let containerCategory = UIView()
  let labelCategory = UILabel()
  let buttonShare = UIButton()
  
  static let identifier = "ListCell"
  var fact: FactView?
  
  func setup(data: FactView) {
    fact = data
    setShadow()
    addContainer()
    addTLabelText()
    addContainerCategory()
    addTLabelCategory()
    addButtonShare()
  }
  
  func setShadow() {
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOpacity = 1
    contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
    contentView.layer.shadowRadius = 3
  }
  
  func addContainer() {
    contentView.addSubview(container)
    container.backgroundColor = .white
    container.layer.cornerRadius = 10
    container.addConstraint(attribute: .top, alignElement: contentView, alignElementAttribute: .top, constant: 10)
    container.addConstraint(attribute: .right, alignElement: contentView, alignElementAttribute: .right, constant: 20)
    container.addConstraint(attribute: .left, alignElement: contentView, alignElementAttribute: .left, constant: 20)
    container.addConstraint(attribute: .bottom, alignElement: contentView, alignElementAttribute: .bottom, constant: 10)
  }
  
  func addTLabelText() {
    container.addSubview(labelText)
    labelText.text = fact?.text ?? ""
    labelText.numberOfLines = 0
    labelText.setFontSizeText()
    labelText.addConstraint(attribute: .top, alignElement: container, alignElementAttribute: .top, constant: 10)
    labelText.addConstraint(attribute: .right, alignElement: container, alignElementAttribute: .right, constant: 10)
    labelText.addConstraint(attribute: .left, alignElement: container, alignElementAttribute: .left, constant: 10)
  }
  
  func addContainerCategory() {
    container.addSubview(containerCategory)
    containerCategory.backgroundColor = .black
    containerCategory.layer.cornerRadius = 10
    containerCategory.addConstraint(attribute: .top, alignElement: labelText, alignElementAttribute: .bottom, constant: 20)
    containerCategory.addConstraint(attribute: .left, alignElement: container, alignElementAttribute: .left, constant: 10)
    containerCategory.addConstraint(attribute: .bottom, alignElement: container, alignElementAttribute: .bottom, constant: 10)
  }
  
  func addTLabelCategory() {
    containerCategory.addSubview(labelCategory)
    labelCategory.text = fact?.category.uppercased() ?? ""
    labelCategory.textColor = .white
    labelCategory.addConstraint(attribute: .top, alignElement: containerCategory, alignElementAttribute: .top, constant: 10)
    labelCategory.addConstraint(attribute: .left, alignElement: containerCategory, alignElementAttribute: .left, constant: 15)
    labelCategory.addConstraint(attribute: .right, alignElement: containerCategory, alignElementAttribute: .right, constant: 15)
    labelCategory.addConstraint(attribute: .bottom, alignElement: containerCategory, alignElementAttribute: .bottom, constant: 10)
  }
  
  func addButtonShare() {
    container.addSubview(buttonShare)
    buttonShare.setImage(UIImage(named: "icon_share")?.withRenderingMode(.alwaysTemplate), for: .normal)
    buttonShare.tintColor = .blue
    buttonShare.addConstraint(attribute: .right, alignElement: container, alignElementAttribute: .right, constant: 10)
    buttonShare.addConstraint(attribute: .height, alignElement: nil, alignElementAttribute: .notAnAttribute, constant: 30)
    buttonShare.addConstraint(attribute: .width, alignElement: nil, alignElementAttribute: .notAnAttribute, constant: 30)
    buttonShare.addConstraint(attribute: .centerY, alignElement: containerCategory, alignElementAttribute: .centerY, constant: 0)
  }
  
}
