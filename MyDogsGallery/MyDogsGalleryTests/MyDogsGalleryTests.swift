//
//  MyDogsGalleryTests.swift
//  MyDogsGalleryTests
//
//  Created by Kapil Khedkar on 19/07/24.
//

import XCTest
@testable import MyDogsGallery
import CoreData

class MyDogsGalleryTests: XCTestCase {

    var dogImageFetcher: DogImageFetcher!

    override func setUpWithError() throws {
        dogImageFetcher = DogImageFetcher()
        clearCoreData()
    }

    override func tearDownWithError() throws {
        dogImageFetcher = nil
        clearCoreData()
    }
    
    private func clearCoreData() {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = DogImage.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear Core Data: \(error)")
        }
    }
    
    func testGetImage() throws {
        let expectation = self.expectation(description: "Fetching image")
        
        dogImageFetcher.getImage { result in
            switch result {
            case .success(let imageUrl):
                XCTAssertTrue(imageUrl.hasPrefix("https://"), "URL should be valid")
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
                    case .success(let imageUrl):
                        XCTAssertTrue(imageUrl.hasPrefix("https://"), "URL should be valid")
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
    
    func testGetPreviousImage() throws {
        let expectation = self.expectation(description: "Fetching previous image")
        
        dogImageFetcher.getImage { result in
            switch result {
            case .success:
                self.dogImageFetcher.getNextImage { _ in
                    self.dogImageFetcher.getPreviousImage { result in
                        switch result {
                        case .success(let imageUrl):
                            XCTAssertTrue(imageUrl.hasPrefix("https://"), "URL should be valid")
                        case .failure(let error):
                            XCTFail("Error: \(error.localizedDescription)")
                        }
                        expectation.fulfill()
                    }
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
        let numberOfImages = 5
        
        dogImageFetcher.getImages(number: numberOfImages) { result in
            switch result {
            case .success(let imageUrls):
                XCTAssertEqual(imageUrls.count, numberOfImages, "Should fetch \(numberOfImages) images")
                for imageUrl in imageUrls {
                    XCTAssertTrue(imageUrl.hasPrefix("https://"), "URL should be valid")
                }
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
