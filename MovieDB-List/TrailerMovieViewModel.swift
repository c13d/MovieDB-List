//
//  TrailerMovieViewModel.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import RxSwift
import Foundation

class TrailerMovieViewModel{
    let disposeBag = DisposeBag()
    let youtubeVideos = PublishSubject<[Video]>()
    let movieId: Int
    
    init(movieId: Int){
        self.movieId = movieId
    }
    
    func fetchYoutubeVideos(){
        MovieService.shared.downloadYoutubeID(movieId: movieId).subscribe { [weak self] event in
            switch event{
            case .next(let ids):
                self?.youtubeVideos.onNext(ids.results)
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }.disposed(by: disposeBag)
    }
}


