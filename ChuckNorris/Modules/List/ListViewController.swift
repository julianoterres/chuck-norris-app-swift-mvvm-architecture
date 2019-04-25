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
import TagListView

class ListViewController: UIViewController {
  
  let searchBar = UISearchBar()
  let tableView = UITableView()
  let searchContainer = UIView()
  let loader = UIActivityIndicatorView()
  let alertResult = UILabel()
  var searchContainerConstraintTop: NSLayoutConstraint?
  var searchContainerConstraintBottom: NSLayoutConstraint?
  
  let disposeBag = DisposeBag()
  var searchViewController: SearchViewController!
  var router: ListRouterProtocol!
  var viewModel: ListViewModel! { didSet { addRxEventsInElements() } }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    addElementsInScreen()
  }
  
  func setupView() {
    view.backgroundColor = .white
  }
  
  func addElementsInScreen() {
    addSeputNavigation()
    addSearchBar()
    addLoader()
    addTableView()
    addAlertResult()
    addSearchContainer()
    addSearchView()
  }
  
  func addSeputNavigation() {
    title = "Chuck Norris Facts"
    navigationItem.largeTitleDisplayMode = .never
    navigationController?.navigationBar.prefersLargeTitles = false
  }
  
  func addLoader() {
    view.addSubview(loader)
    loader.startAnimating()
    loader.color = .black
    loader.isUserInteractionEnabled = false
    loader.addConstraint(attribute: .width, alignElement: nil, alignElementAttribute: .notAnAttribute, constant: 20)
    loader.addConstraint(attribute: .height, alignElement: nil, alignElementAttribute: .notAnAttribute, constant: 20)
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
    tableView.separatorStyle = .none
    tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    tableView.addConstraint(attribute: .top, alignElement: searchBar, alignElementAttribute: .bottom, constant: 0)
    tableView.addConstraint(attribute: .right, alignElement: view, alignElementAttribute: .right, constant: 0)
    tableView.addConstraint(attribute: .left, alignElement: view, alignElementAttribute: .left, constant: 0)
    tableView.addConstraint(attribute: .bottom, alignElement: view, alignElementAttribute: .bottom, constant: 0)
    loader.addConstraint(attribute: .centerX, alignElement: tableView, alignElementAttribute: .centerX, constant: 0)
    loader.addConstraint(attribute: .centerY, alignElement: tableView, alignElementAttribute: .centerY, constant: 0)
  }
  
  func addSearchContainer() {
    view.addSubview(searchContainer)
    searchContainer.clipsToBounds = true
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
  
  func addAlertResult() {
    view.addSubview(alertResult)
    alertResult.text = "No results found"
    alertResult.textAlignment = .center
    alertResult.isUserInteractionEnabled = false
    alertResult.isHidden = true
    alertResult.addConstraint(attribute: .top, alignElement: searchBar, alignElementAttribute: .bottom, constant: 20)
    alertResult.addConstraint(attribute: .right, alignElement: view, alignElementAttribute: .right, constant: 0)
    alertResult.addConstraint(attribute: .left, alignElement: view, alignElementAttribute: .left, constant: 0)
  }
  
  func showSearchView(_ show: Bool) {
    searchViewController.scrollView.contentOffset = CGPoint(x: 0, y: 0)
    UIView.animate(withDuration: 0.5) {
      self.searchContainerConstraintTop?.isActive = show
      self.searchContainerConstraintBottom?.isActive = !show
      self.view.layoutIfNeeded()
    }
  }
  
  func addRxEventsInElements() {
    
    viewModel.hideTable.drive(tableView.rx.isHidden).disposed(by: disposeBag)
    
    viewModel.hideNoResultFound.drive(alertResult.rx.isHidden).disposed(by: disposeBag)
    
    viewModel.reloadRecentTags.drive(searchViewController.loaderRecents).disposed(by: disposeBag)
    
    searchViewController.tagSelected.asObservable().subscribe(onNext: { [weak self] _ in
      self?.showSearchView(false)
      self?.tableView.contentOffset = CGPoint(x: 0, y: 0)
      self?.view.endEditing(true)
    }).disposed(by: disposeBag)
    
    viewModel.facts.drive(tableView.rx.items(cellIdentifier: ListCell.identifier, cellType: ListCell.self)) { (_, fact, cell) in
      cell.setup(data: fact)
      cell.buttonShare.rx.tap.subscribe(onNext: { [weak self] _ in
        self?.router.openShare(fact: cell.fact)
      }).disposed(by: self.disposeBag)
    }.disposed(by: disposeBag)
    
    searchBar.rx.textDidBeginEditing.subscribe(onNext: { [weak self] _ in
      self?.showSearchView(true)
      self?.tableView.contentOffset = CGPoint(x: 0, y: 0)
    }).disposed(by: disposeBag)
    
    searchBar.rx.searchButtonClicked.subscribe(onNext: { [weak self] _ in
      self?.showSearchView(false)
      self?.view.endEditing(true)
    }).disposed(by: disposeBag)
    
  }
  
}
