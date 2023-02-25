//
//  ReviewMovieViewModel.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 25/02/23.
//

import RxCocoa
import RxSwift

class ReviewMovieViewModel{
    let disposeBag = DisposeBag()
    let movieId: Int
    var pageCounter = 0
    
    let reviews = BehaviorRelay<[Review]>(value: [])
    let reviewIsEmpty = PublishSubject<Bool>()
    var isFetchingData = false
    
    init(movieId: Int){
        self.movieId = movieId
    }
    
    func fetchReviews(){
        if isFetchingData == true {return}
        pageCounter += 1
        isFetchingData = true
        
        MovieService.shared.downloadReview(page: pageCounter, movieId: movieId).subscribe { [weak self] event in
            guard let self = self else { return }
            switch event{
            case .next(let movies):
                var tempResult = self.reviews.value
                tempResult += movies.results
                self.reviews.accept(tempResult)
            case .error(let error):
                print("\(error)")
                break
            case .completed:
                if self.reviews.value.isEmpty {
                    self.reviewIsEmpty.onNext(true)
                    self.isFetchingData = false
                }else{
                    self.reviewIsEmpty.onNext(false)
                    self.isFetchingData = false
                }
                break
            }
        }.disposed(by: disposeBag)
    }
    
}
