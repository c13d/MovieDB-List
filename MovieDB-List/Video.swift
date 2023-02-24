//
//  Video.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import Foundation

struct VideoResult: Codable {
    let id: Int
    let results: [Video]
}

struct Video: Codable {
    let key: String
    let site: String
    let name: String
}
