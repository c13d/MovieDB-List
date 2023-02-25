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
    
    var movies = BehaviorRelay<[TopRatedResult]>(value: [])
    var pageCounter = 0
    var isFetchingData = false
    
    var genres = [GenreResult]()
    
    init(){
        fetchGenresAndMovie()
    }
    
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
                self.isFetchingData = false
            case .completed:
                self.isFetchingData = false
            }
            
        }.disposed(by: disposeBag)
    }
    
    private func fetchGenresAndMovie(){
        
        pageCounter = 0
        MovieService.shared.downloadGenres().subscribe { event in
            switch event{
            case .next(let genres):
                self.genres = genres.genres
                self.fetchMoreMovie()
            case .error(let error):
                print(error)
            case .completed:
                print("completed download genres")
            }
        }.disposed(by: disposeBag)
    }
    
    
}
