//
//  MVVMDemoTests.swift
//  MVVMDemoTests
//
//  Created by Yash Barot on 27/12/23.
//

import XCTest
@testable import MVVMDemo

final class MVVMDemoTests: XCTestCase {
    
    var apiService: APIServiceProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiService = APIService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiService = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    // This is an API unit test for fetch data properlly or not
    func testFetchArticlesData() {
           let expectation = self.expectation(description: "Fetch Articles data")
        apiService.getArticlesList(period: "7") { success, articles, error in
            if let error = error {
             
               
                XCTFail("Error: \(error.localizedDescription)")
            } else {
                XCTAssertEqual("Total \(articles!.numResults ?? 0) Fetch", "Total \(articles!.numResults ?? 0) Fetch")
                
                
            }
            expectation.fulfill()
        }
           wait(for: [expectation], timeout: 30.0)
       }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
