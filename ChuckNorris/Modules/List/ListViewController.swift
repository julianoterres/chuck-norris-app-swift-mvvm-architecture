//
//  ListViewController.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
  
  let searchBar = UISearchBar()
  let tableView = UITableView()
  let searchContainer = UIView()
  var searchContainerConstraintTop: NSLayoutConstraint?
  var searchContainerConstraintBottom: NSLayoutConstraint?
  
  let disposeBag = DisposeBag()
  var searchViewController: SearchViewController!
  var router: ListRouterProtocol!
  var viewModel: ListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupViewModel()
    addElementsInScreen()
    addRxEventsInElements()
  }
  
  func setupView() {
    view.backgroundColor = .white
  }
  
  func setupViewModel() {
    viewModel = ListViewModel(
      didSearchbarAction: searchBar.rx.searchButtonClicked
    )
  }
  
  func addElementsInScreen() {
    addSeputNavigation()
    addSearchBar()
    addTableView()
    addSearchContainer()
    addSearchView()
  }
  
  func addSeputNavigation() {
    title = "Chuck Norris Facts"
    navigationItem.largeTitleDisplayMode = .automatic
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func addSearchBar() {
    view.addSubview(searchBar)
    searchBar.placeholder = "Search for Facts"
    searchBar.addConstraint(attribute: .top, alignElement: view.safeAreaLayoutGuide, alignElementAttribute: .top, constant: 0)
    searchBar.addConstraint(attribute: .right, alignElement: view, alignElementAttribute: .right, constant: 0)
    searchBar.addConstraint(attribute: .left, alignElement: view, alignElementAttribute: .left, constant: 0)
    searchBar.addConstraint(attribute: .height, alignElement: nil, alignElementAttribute: .notAnAttribute, constant: 44)
  }
  
  func addTableView() {
    view.addSubview(tableView)
    tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableView.automaticDimension
    tableView.allowsSelection = false
    tableView.addConstraint(attribute: .top, alignElement: searchBar, alignElementAttribute: .bottom, constant: 0)
    tableView.addConstraint(attribute: .right, alignElement: view, alignElementAttribute: .right, constant: 0)
    tableView.addConstraint(attribute: .left, alignElement: view, alignElementAttribute: .left, constant: 0)
    tableView.addConstraint(attribute: .bottom, alignElement: view, alignElementAttribute: .bottom, constant: 0)
  }
  
  func addSearchContainer() {
    view.addSubview(searchContainer)
    searchContainerConstraintTop = searchContainer.addConstraint(attribute: .top, alignElement: searchBar, alignElementAttribute: .bottom, constant: 0)
    searchContainerConstraintBottom = searchContainer.addConstraint(attribute: .top, alignElement: view, alignElementAttribute: .bottom, constant: 0)
    searchContainer.addConstraint(attribute: .right, alignElement: view, alignElementAttribute: .right, constant: 0)
    searchContainer.addConstraint(attribute: .left, alignElement: view, alignElementAttribute: .left, constant: 0)
    searchContainer.addConstraint(attribute: .bottom, alignElement: view, alignElementAttribute: .bottom, constant: 0)
    searchContainerConstraintTop?.isActive = false
  }
  
  func addSearchView() {
    searchContainer.addSubview(searchViewController.view)
    addChild(searchViewController)
    searchViewController.view.addConstraint(attribute: .top, alignElement: searchContainer, alignElementAttribute: .top, constant: 0)
    searchViewController.view.addConstraint(attribute: .right, alignElement: searchContainer, alignElementAttribute: .right, constant: 0)
    searchViewController.view.addConstraint(attribute: .left, alignElement: searchContainer, alignElementAttribute: .left, constant: 0)
    searchViewController.view.addConstraint(attribute: .bottom, alignElement: searchContainer, alignElementAttribute: .bottom, constant: 0)
  }
  
  func showSearchView(_ show: Bool) {
    UIView.animate(withDuration: 0.5) {
      self.searchContainerConstraintTop?.isActive = show
      self.searchContainerConstraintBottom?.isActive = !show
      self.view.layoutIfNeeded()
    }
  }
  
  func addRxEventsInElements() {
    
    viewModel.facts.drive(tableView.rx.items(cellIdentifier: ListCell.identifier, cellType: ListCell.self)) { [weak self] _, fact, cell in
      cell.setup(data: fact)
    }.disposed(by: disposeBag)
    
    searchBar.rx.textDidBeginEditing.subscribe(onNext: { [weak self] _ in
      self?.showSearchView(true)
    }).disposed(by: disposeBag)
    
    searchBar.rx.searchButtonClicked.subscribe(onNext: { [weak self] _ in
      self?.showSearchView(false)
      self?.view.endEditing(true)
    }).disposed(by: disposeBag)
    
  }
  
}
