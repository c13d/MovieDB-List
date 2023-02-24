//
//  ListMovieCellViewModel.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 23/02/23.
//

import Foundation
import UIKit
import RxSwift

struct ListMovieCellViewModel{
    
    let movie: TopRatedResult
    let allGenres: [GenreResult]
    
    
    var title: String{
        return movie.title.uppercased()
    }
    
    var genres: String{
        let movie_genre = self.allGenres.filter({ movie.genre_ids.contains($0.id) }).map({$0.name})
        return movie_genre.joined(separator: ", ")
    }
    
    var imageUrl: String{
        return "https://image.tmdb.org/t/p/w342/" + movie.poster_path
    }
    
    
    
    init(movie: TopRatedResult, allGenres: [GenreResult]) {
        self.movie = movie
        self.allGenres = allGenres
    }
    
}
