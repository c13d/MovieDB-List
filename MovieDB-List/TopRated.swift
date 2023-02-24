//
//  ListMovie.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 23/02/23.
//

import Foundation
struct TopRated: Codable {
    let results: [TopRatedResult]
}

struct TopRatedResult: Codable {
    let id: Int
    let adult: Bool
    let genre_ids: [Int]
    let title: String
    let release_date: String
    let video: Bool
    let overview: String
    let poster_path: String
}
