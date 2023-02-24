//
//  MovieService.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 23/02/23.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

enum NetworkError: Error{
    case NetworkFailed
    case DecodeFailed
}

struct MovieService{
    static let shared = MovieService()
    private let listMovieURL = "https://api.themoviedb.org/3/movie/top_rated?api_key=6c489b7a4ed215ea82009dbe1ea15061&language=en-US&page="
    
    private let genreURL =  "https://api.themoviedb.org/3/genre/movie/list?api_key=6c489b7a4ed215ea82009dbe1ea15061"
    
    func downloadListMovie(page: Int) -> Observable<TopRated> {
        return Observable<TopRated>.create { observer in
            let url = self.listMovieURL + "\(page)"
            let request = AF.request(url).response  { response in
                switch response.result {
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(TopRated.self, from: data!)
                        observer.onNext(jsonData)
                        observer.onCompleted()
                    }catch{
                        observer.onError(NetworkError.DecodeFailed)
                    }
                case . failure(_):
                    observer.onError(NetworkError.NetworkFailed)
                }
            }
            return Disposables.create{
                request.cancel()
            }
        }
    }
    
    func downloadGenres() -> Observable<Genre> {
        return Observable<Genre>.create { observer in
            let request = AF.request(genreURL).response  { response in
                switch response.result {
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(Genre.self, from: data!)
                        observer.onNext(jsonData)
                        observer.onCompleted()
                    }catch{
                        observer.onError(NetworkError.DecodeFailed)
                    }
                case . failure(_):
                    observer.onError(NetworkError.NetworkFailed)
                }
            }
            return Disposables.create{
                request.cancel()
            }
        }
    }
    
    func downloadYoutubeID(movieId: Int) -> Observable<VideoResult>{
        return Observable<VideoResult>.create { observer in
            let url = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=6c489b7a4ed215ea82009dbe1ea15061&language=en-US"
            let request = AF.request(url).response { response in
                switch response.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(VideoResult.self, from: data!)
                        observer.onNext(jsonData)
                        observer.onCompleted()
                    }catch{
                        observer.onError(NetworkError.DecodeFailed)
                    }
                case .failure(_):
                    observer.onError(NetworkError.NetworkFailed)
                }
            }
            return Disposables.create{
                request.cancel()
            }
        }
    }
    
}
