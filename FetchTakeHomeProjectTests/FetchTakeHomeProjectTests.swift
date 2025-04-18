//
//  FetchTakeHomeProjectTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by Cool-Ish on 4/17/25.
//

import XCTest
@testable import FetchTakeHomeProject

final class FetchTakeHomeProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    struct DummyRecipe: Codable, Equatable {
        let name: String
    }

    func testDecodeValidJSON() async throws {
        let store = NetworkingStore()
        let json = """
            { "name": "Spaghetti" }
            """.data(using: .utf8)!
        
        let dummyURL = URL(string: "https://example.com/recipe.json")!
        
        let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let cachedResponse = CachedURLResponse(response: response, data: json)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: dummyURL))
        
        let recipe: DummyRecipe = try await store.fetchData(from: dummyURL)
        XCTAssertEqual(recipe.name, "Spaghetti")
    }
    
    func testInvalidJSONFailsToDecode() async {
        let store = NetworkingStore()
        let badJSON = "not json".data(using: .utf8)!
        let dummyURL = URL(string: "https://example.com/bad.json")!
        
        let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let cachedResponse = CachedURLResponse(response: response, data: badJSON)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: dummyURL))
        
        do {
            let _: DummyRecipe = try await store.fetchData(from: dummyURL)
            XCTFail("Should have failed decoding")
        } catch {
            // ✅
        }
    }
    
    func testImageFailsWithBadData() async {
        let store = NetworkingStore()
        let dummyURL = URL(string: "https://example.com/image.png")!
        let fakeImageData = Data("not an image".utf8)
        
        let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let cachedResponse = CachedURLResponse(response: response, data: fakeImageData)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: dummyURL))
        
        do {
            let _ = try await store.fetchImage(from: dummyURL)
            XCTFail("Should have thrown invalidImageData")
        } catch NetworkingError.invalidImageData {
            // ✅
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testIsCachedReturnsTrue() {
        let store = NetworkingStore()
        let dummyURL = URL(string: "https://example.com/test")!
        let fakeData = Data("test".utf8)
        let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let cachedResponse = CachedURLResponse(response: response, data: fakeData)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: dummyURL))
        
        XCTAssertTrue(store.isCached(url: dummyURL))
    }
}
