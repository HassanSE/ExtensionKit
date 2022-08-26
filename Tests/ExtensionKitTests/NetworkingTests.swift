//
//  NetworkingTests.swift
//  
//
//  Created by Muhammad Hassan on 25/08/2022.
//

import XCTest
@testable import ExtensionKit

final class NetworkingTests: XCTestCase {
    
    func testLoadDataCall() {
        let httpClient = ExtensionKit.Networking.HTTPClient()
        let expectation = XCTestExpectation(description: "Load request is successful")
        let url = URL(string: "https://www.apple.com")!
        httpClient.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                XCTAssertNotNil(returnedData)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
