//
//  ListViewModel.swift
//  ChuckNorris
//
//  Created by Juliano Terres on 22/04/19.
//  Copyright © 2019 Juliano Terres. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
  
  let facts: Driver<[Fact]>
  
  init(didSearchbarAction: ControlEvent<Void>) {
    
    facts = didSearchbarAction.do(onNext: { termSearch in
      
    }).map({
      return [Fact(name: "João"), Fact(name: "Pedro")]
    }).asDriver(onErrorJustReturn: [])
    
  }
  
}



//class MovieListViewModel {
//
//  let movies: Driver<[MovieSectionsItens]>
//  let mainLoadingActive: Driver<Bool>
//  let footerLoadingActive: Driver<Bool>
//  private let disposeBag = DisposeBag()
//
//  init(loadMore: Observable<Void>, service: MoviesService) {
//
//    var page = 1
//    let showLoader = BehaviorRelay(value: true)
//    let showFooterLoader = BehaviorRelay(value: true)
//
//    self.mainLoadingActive = showLoader.startWith(true)
//      .asDriver(onErrorJustReturn: true)
//
//    self.footerLoadingActive = showFooterLoader.startWith(true)
//      .asDriver(onErrorJustReturn: true)
//
//    self.movies = loadMore.startWith(())
//      .flatMapLatest { _ in service.getPopular(page: page) }
//      .do(onNext: { movieResponseData in
//        showFooterLoader.accept(!(movieResponseData.total_pages == page))
//        showLoader.accept(false)
//        page += 1
//      })
//      .map { $0.results }
//      .scan([]) { (moviesAlredyAdd, newMovies) -> [Movie] in
//        return moviesAlredyAdd + newMovies
//      }
//      .map { [MovieSectionsItens(header: "", items: $0)] }
//      .asDriver(onErrorJustReturn: [])
//
//  }
//
//}
