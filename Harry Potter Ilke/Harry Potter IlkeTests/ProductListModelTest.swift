//
//  ProductListModelTest.swift
//  Harry Potter IlkeTests
//
//  Created by Ilke Yucel on 25.07.2021.
//

 @testable import Harry_Potter_Ilke

import XCTest

class ProductListModelTest: XCTestCase {
    
    var sut: ProductList?

    override func setUpWithError() throws {
        sut = ProductList()
        sut?.author = "Author"
        sut?.imageURL = "ImageURL"
    }

    func testTitleIsNull() {
        XCTAssert(sut?.title == nil)
    }
    
    func testTitleIsNotNull() {
        sut?.title = "Title"
        XCTAssert(sut?.title == "Title")
    }
    
    func testAuthorIsNotNull() {
        XCTAssert(sut?.author == "Author")
    }
    
    func testImageIsNotNull() {
        XCTAssert(sut?.imageURL == "ImageURL")
    }
    
    func testUUID() {
        XCTAssert(sut?.uuid != nil)
    }

    
    func testCompareProduct() {
        let sut2 = ProductList(title: "Title2", author: "Author2", imageURL: "imageURL2")
        
        XCTAssert(sut != sut2)
        XCTAssert(sut?.uuid != sut2.uuid)        
    }

}
