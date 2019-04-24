//
//  ListView.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 23/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit

class ListView: UIView {
  
  let searchBar = UISearchBar()
  let tableView = UITableView()
  let searchContainer = UIView()
  var searchView: UIView
  var searchContainerConstraintTop: NSLayoutConstraint?
  var searchContainerConstraintBottom: NSLayoutConstraint?
  
  init(frame: CGRect, searchView: UIView) {
    self.searchView = searchView
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addSearchBar() {
    addSubview(searchBar)
    searchBar.placeholder = "Search for Facts"
    searchBar.addConstraint(attribute: .top, alignElement: self, alignElementAttribute: .top, constant: 0)
    searchBar.addConstraint(attribute: .right, alignElement: self, alignElementAttribute: .right, constant: 0)
    searchBar.addConstraint(attribute: .left, alignElement: self, alignElementAttribute: .left, constant: 0)
    searchBar.addConstraint(attribute: .height, alignElement: nil, alignElementAttribute: .notAnAttribute, constant: 44)
  }
  
  func addTableView() {
    addSubview(tableView)
    tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableView.automaticDimension
    tableView.allowsSelection = false
    tableView.addConstraint(attribute: .top, alignElement: searchBar, alignElementAttribute: .bottom, constant: 0)
    tableView.addConstraint(attribute: .right, alignElement: self, alignElementAttribute: .right, constant: 0)
    tableView.addConstraint(attribute: .left, alignElement: self, alignElementAttribute: .left, constant: 0)
    tableView.addConstraint(attribute: .bottom, alignElement: self, alignElementAttribute: .bottom, constant: 0)
  }
  
  func addSearchContainer() {
    addSubview(searchContainer)
    searchContainerConstraintTop = searchContainer.addConstraint(attribute: .top, alignElement: searchBar, alignElementAttribute: .bottom, constant: 0)
    searchContainerConstraintBottom = searchContainer.addConstraint(attribute: .top, alignElement: self, alignElementAttribute: .bottom, constant: 0)
    searchContainer.addConstraint(attribute: .right, alignElement: self, alignElementAttribute: .right, constant: 0)
    searchContainer.addConstraint(attribute: .left, alignElement: self, alignElementAttribute: .left, constant: 0)
    searchContainer.addConstraint(attribute: .bottom, alignElement: self, alignElementAttribute: .bottom, constant: 0)
    searchContainerConstraintTop?.isActive = false
  }
  
  func addSearchView() {
    searchContainer.addSubview(searchView)
    searchView.addConstraint(attribute: .top, alignElement: searchContainer, alignElementAttribute: .top, constant: 0)
    searchView.addConstraint(attribute: .right, alignElement: searchContainer, alignElementAttribute: .right, constant: 0)
    searchView.addConstraint(attribute: .left, alignElement: searchContainer, alignElementAttribute: .left, constant: 0)
    searchView.addConstraint(attribute: .bottom, alignElement: searchContainer, alignElementAttribute: .bottom, constant: 0)
  }
  
}
