//
//  ListMovieCellViewModelTest.swift
//  MovieDB-ListTests
//
//  Created by Christophorus Davin on 25/02/23.
//

import XCTest
@testable import MovieDB_List

final class ListMovieCellViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenFilteringGenre(){
        let sampleTopRatedResult = TopRatedResult(id: 1, adult: true, genre_ids: [1,3,6], title: "Peterpan", release_date: "12-1-2022", video: false, overview: "overview", poster_path: "poster")
        
        let sampleGenreResult = [
            GenreResult(id: 1, name: "Action"),
            GenreResult(id: 2, name: "Horror"),
            GenreResult(id: 3, name: "Thriller"),
            GenreResult(id: 4, name: "Romance"),
            GenreResult(id: 5, name: "Kids"),
            GenreResult(id: 6, name: "Mystery"),
        ]
        
        let viewModel = ListMovieCellViewModel(movie: sampleTopRatedResult, allGenres: sampleGenreResult)
        let filteredGenre = viewModel.genres
        
        XCTAssertEqual(filteredGenre, "Action, Thriller, Mystery")
    }
    
    func testWhenFilteringUnlistedGenre(){
        let sampleTopRatedResult = TopRatedResult(id: 1, adult: true, genre_ids: [9,15], title: "Peterpan", release_date: "12-1-2022", video: false, overview: "overview", poster_path: "poster")
        
        let sampleGenreResult = [
            GenreResult(id: 1, name: "Action"),
            GenreResult(id: 2, name: "Horror"),
            GenreResult(id: 3, name: "Thriller"),
            GenreResult(id: 4, name: "Romance"),
            GenreResult(id: 5, name: "Kids"),
            GenreResult(id: 6, name: "Mystery"),
        ]
        
        let viewModel = ListMovieCellViewModel(movie: sampleTopRatedResult, allGenres: sampleGenreResult)
        let filteredGenre = viewModel.genres
        
        XCTAssertEqual(filteredGenre, "")
    }
    
    func testWhenMappingAges(){
        let sampleTopRatedResult = TopRatedResult(id: 1, adult: true, genre_ids: [9,15], title: "Peterpan", release_date: "12-1-2022", video: false, overview: "overview", poster_path: "poster")
        let sampleTopRatedResult2 = TopRatedResult(id: 1, adult: false, genre_ids: [9,15], title: "Peterpan", release_date: "12-1-2022", video: false, overview: "overview", poster_path: "poster")
        
        let sampleGenreResult = [
            GenreResult(id: 1, name: "Action"),
            GenreResult(id: 2, name: "Horror"),
            GenreResult(id: 3, name: "Thriller"),
            GenreResult(id: 4, name: "Romance"),
            GenreResult(id: 5, name: "Kids"),
            GenreResult(id: 6, name: "Mystery"),
        ]
        
        let viewModel = ListMovieCellViewModel(movie: sampleTopRatedResult, allGenres: sampleGenreResult)
        let viewModel2 = ListMovieCellViewModel(movie: sampleTopRatedResult2, allGenres: sampleGenreResult)
        
        let filteredGenre = viewModel.ages
        let filteredGenre2 = viewModel2.ages
        
        XCTAssertEqual(filteredGenre, "D 18+")
        XCTAssertEqual(filteredGenre2, "R 13+")
    }
    
    

}
