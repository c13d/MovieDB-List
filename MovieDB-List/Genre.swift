//
//  Genre.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import Foundation
struct Genre: Codable {
    let genres: [GenreResult]
}

struct GenreResult: Codable {
    let id: Int
    let name: String
}
