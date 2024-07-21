//
//  MyDogsGalleryTests.swift
//  MyDogsGalleryTests
//
//  Created by Kapil Khedkar on 19/07/24.
//

import XCTest
@testable import MyDogsGallery
import RealmSwift

class MyDogsGalleryTests: XCTestCase {

    var dogImageFetcher: DogImageFetcher!
    
    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        dogImageFetcher = DogImageFetcher()
    }
    
    override func tearDownWithError() throws {
        dogImageFetcher = nil
    }
    
    func testGetImage() throws {
        let expectation = self.expectation(description: "Fetching image")
        
        dogImageFetcher.getImage { result in
            switch result {
            case .success(let image):
                XCTAssertTrue(image.url.hasPrefix("https://"), "URL should be valid")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetNextImage() throws {
        let expectation = self.expectation(description: "Fetching next image")
        
        dogImageFetcher.getImage { result in
            switch result {
            case .success:
                self.dogImageFetcher.getNextImage { result in
                    switch result {
                    case .success(let image):
                        XCTAssertTrue(image.url.hasPrefix("https://"), "URL should be valid")
                    case .failure(let error):
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                    expectation.fulfill()
                }
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetImages() throws {
        let expectation = self.expectation(description: "Fetching multiple images")
        
        dogImageFetcher.getImages(number: 5) { result in
            switch result {
            case .success(let imageUrls):
                XCTAssertEqual(imageUrls.count, 5, "Should return 5 images")
                imageUrls.forEach { url in
                    XCTAssertTrue(url.hasPrefix("https://"), "URL should be valid")
                }
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
