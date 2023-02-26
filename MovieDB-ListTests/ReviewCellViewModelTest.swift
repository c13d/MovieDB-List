//
//  ReviewCellViewModelTest.swift
//  MovieDB-ListTests
//
//  Created by Christophorus Davin on 26/02/23.
//

import XCTest
@testable import MovieDB_List

final class ReviewCellViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWhenRetrievingprofilePictureText(){
        let review1 = Review(author: "Christophorus Davin", content: "any content", created_at: "2019-07-30T08:28:10.884Z")
        let review2 = Review(author: "ChristophorusDavin", content: "any content", created_at: "2019-07-30T08:28:10.884Z")
        let review3 = Review(author: "C", content: "any content", created_at: "2019-07-30T08:28:10.884Z")
        let review4 = Review(author: "C ", content: "any content", created_at: "2019-07-30T08:28:10.884Z")
        let review5 = Review(author: "", content: "any content", created_at: "2019-07-30T08:28:10.884Z")
        let review6 = Review(author: "Chris  A", content: "any content", created_at: "2019-07-30T08:28:10.884Z")
        let review7 = Review(author: "Chris  Dav In", content: "any content", created_at: "2019-07-30T08:28:10.884Z")
        
        
        let viewModel1 = ReviewCellViewModel(review: review1)
        let viewModel2 = ReviewCellViewModel(review: review2)
        let viewModel3 = ReviewCellViewModel(review: review3)
        let viewModel4 = ReviewCellViewModel(review: review4)
        let viewModel5 = ReviewCellViewModel(review: review5)
        let viewModel6 = ReviewCellViewModel(review: review6)
        let viewModel7 = ReviewCellViewModel(review: review7)
        
        let text1 = viewModel1.profilePictureText
        let text2 = viewModel2.profilePictureText
        let text3 = viewModel3.profilePictureText
        let text4 = viewModel4.profilePictureText
        let text5 = viewModel5.profilePictureText
        let text6 = viewModel6.profilePictureText
        let text7 = viewModel7.profilePictureText
        
        XCTAssertEqual(text1, "CD")
        XCTAssertEqual(text2, "C")
        XCTAssertEqual(text3, "C")
        XCTAssertEqual(text4, "C")
        XCTAssertEqual(text5, "")
        XCTAssertEqual(text6, "CA")
        XCTAssertEqual(text7, "CD")
    }
}
