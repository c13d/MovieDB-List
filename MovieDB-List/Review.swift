//
//  Review.swift
//  MovieDB-List
//
//  Created by Christophorus Davin on 24/02/23.
//

import Foundation

struct ReviewResult: Codable {
    let results: [Review]
    let total_pages: Int
}

struct Review: Codable {
    let author: String
    let content: String
    let created_at: String
}
