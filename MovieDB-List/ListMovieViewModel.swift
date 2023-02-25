//
//  ListMovieViewModel.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 23/02/23.
//

import Foundation
import RxSwift
import RxCocoa

class ListMovieViewModel{
    
    let disposeBag = DisposeBag()
    let movieService = MovieService.shared
    
    let movies = BehaviorRelay<[TopRatedResult]>(value: [])
    let spinnerIsActive = BehaviorSubject<Bool>(value: false)
    let showErrorLabel = BehaviorSubject<Bool>(value: false)
    
    var pageCounter = 0
    var isFetchingData = false
    
    var genres = [GenreResult]()
    
    func fetchMoreMovie(){
        if genres.count == 0 { return }
        if isFetchingData == true {return}
        
        pageCounter += 1
        isFetchingData = true
        
        movieService.downloadListMovie(page: pageCounter).subscribe{ [weak self] event in
            guard let self = self else { return }
            switch event {
            case .next(let movies):
                var tempResult = self.movies.value
                tempResult += movies.results
                self.movies.accept(tempResult)
            case .error(let error):
                print(error)
                self.showErrorLabel.onNext(true)
                self.isFetchingData = false
            case .completed:
                self.isFetchingData = false
            }
            
        }.disposed(by: disposeBag)
    }
    
    func fetchGenresAndMovie(){
        pageCounter = 0
        movies.accept([])
        spinnerIsActive.onNext(true)
        MovieService.shared.downloadGenres().subscribe { event in
            switch event{
            case .next(let genres):
                self.showErrorLabel.onNext(false)
                self.genres = genres.genres
                self.fetchMoreMovie()
            case .error(let error):
                print("\(error)")
                self.spinnerIsActive.onNext(false)
                self.showErrorLabel.onNext(true)
            case .completed:
                self.spinnerIsActive.onNext(false)
            }
        }.disposed(by: disposeBag)
    }
    
    
}
