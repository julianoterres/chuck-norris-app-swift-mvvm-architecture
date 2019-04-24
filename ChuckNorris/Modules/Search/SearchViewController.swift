//
//  SearchViewController.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TagListView

class SearchViewController: UIViewController {
  
  let scrollView = UIScrollView()
  let suggestionsTagList = TagListView()
  let recentsTagList = TagListView()
  let suggestionsTitle = UILabel()
  let recentsTitle = UILabel()
  
  var disposeBag = DisposeBag()
  var viewModel: SearchViewModel! { didSet { addRxEventsInElements() } }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    addElementsInScreen()
    addRxEventsInElements()
  }
  
  func setupView() {
    view.backgroundColor = .clear
    view.isOpaque = false
  }
  
  func addElementsInScreen() {
    addBlurView()
    addScrollView()
    addSuggestionsTitle()
    addSuggestionsTagList()
    addRecentsTitle()
    addRecentsTagList()
  }
  
  func addBlurView() {
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(blurEffectView)
  }
  
  func addScrollView() {
    view.addSubview(scrollView)
    scrollView.backgroundColor = .clear
    scrollView.addConstraint(attribute: .top, alignElement: view, alignElementAttribute: .top, constant: 20)
    scrollView.addConstraint(attribute: .right, alignElement: view, alignElementAttribute: .right, constant: 0)
    scrollView.addConstraint(attribute: .left, alignElement: view, alignElementAttribute: .left, constant: 0)
    scrollView.addConstraint(attribute: .bottom, alignElement: view, alignElementAttribute: .bottom, constant: 215)
    scrollView.contentSize = CGSize(width: 0, height: (view.frame.size.height + suggestionsTagList.frame.size.height + recentsTagList.frame.size.height))
  }
  
  func addSuggestionsTitle() {
    scrollView.addSubview(suggestionsTitle)
    suggestionsTitle.text = "Suggestions"
    suggestionsTitle.font = .fontBold30
    suggestionsTitle.textColor = .white
    suggestionsTitle.addConstraint(attribute: .top, alignElement: scrollView, alignElementAttribute: .top, constant: 20)
    suggestionsTitle.addConstraint(attribute: .right, alignElement: scrollView, alignElementAttribute: .right, constant: 20)
    suggestionsTitle.addConstraint(attribute: .left, alignElement: scrollView, alignElementAttribute: .left, constant: 20)
  }
  
  func addSuggestionsTagList() {
    scrollView.addSubview(suggestionsTagList)
    suggestionsTagList.textFont = .fontTags
    suggestionsTagList.paddingX = 10
    suggestionsTagList.paddingY = 10
    suggestionsTagList.cornerRadius = 5
    suggestionsTagList.marginX = 10
    suggestionsTagList.marginY = 10
    suggestionsTagList.addConstraint(attribute: .top, alignElement: suggestionsTitle, alignElementAttribute: .bottom, constant: 20)
    suggestionsTagList.addConstraint(attribute: .right, alignElement: scrollView, alignElementAttribute: .right, constant: 20)
    suggestionsTagList.addConstraint(attribute: .left, alignElement: scrollView, alignElementAttribute: .left, constant: 20)
  }
  
  func addRecentsTitle() {
    scrollView.addSubview(recentsTitle)
    recentsTitle.text = "Recents"
    recentsTitle.textColor = .white
    recentsTitle.font = .fontBold30
    recentsTitle.addConstraint(attribute: .top, alignElement: suggestionsTagList, alignElementAttribute: .bottom, constant: 20)
    recentsTitle.addConstraint(attribute: .right, alignElement: scrollView, alignElementAttribute: .right, constant: 20)
    recentsTitle.addConstraint(attribute: .left, alignElement: scrollView, alignElementAttribute: .left, constant: 20)
  }
  
  func addRecentsTagList() {
    scrollView.addSubview(recentsTagList)
    recentsTagList.textFont = UIFont.fontTags
    recentsTagList.paddingX = 10
    recentsTagList.paddingY = 10
    recentsTagList.cornerRadius = 5
    recentsTagList.marginX = 10
    recentsTagList.marginY = 10
    recentsTagList.addConstraint(attribute: .top, alignElement: recentsTitle, alignElementAttribute: .bottom, constant: 20)
    recentsTagList.addConstraint(attribute: .right, alignElement: scrollView, alignElementAttribute: .right, constant: 20)
    recentsTagList.addConstraint(attribute: .left, alignElement: scrollView, alignElementAttribute: .left, constant: 20)
    recentsTagList.addConstraint(attribute: .bottom, alignElement: scrollView, alignElementAttribute: .bottom, constant: 20)
    recentsTagList.addConstraint(attribute: .centerX, alignElement: scrollView, alignElementAttribute: .centerX, constant: 0)
  }
  
  func addRxEventsInElements() {
    
    viewModel.categories.drive(onNext: { [weak self] categories in
      self?.suggestionsTagList.removeAllTags()
      self?.suggestionsTagList.addTags(Array(categories.shuffled().prefix(8)))
    }).disposed(by: disposeBag)
    
    viewModel.recents.drive(onNext: { [weak self] recents in
      self?.recentsTagList.removeAllTags()
      self?.recentsTagList.addTags(recents.reversed())
    }).disposed(by: disposeBag)
    
  }
  
}
