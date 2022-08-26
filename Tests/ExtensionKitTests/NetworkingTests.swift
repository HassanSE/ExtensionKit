//
//  NetworkingTests.swift
//  
//
//  Created by Muhammad Hassan on 25/08/2022.
//

import XCTest
@testable import ExtensionKit

class NetworkSessionMock: NetworkSession {
    
    var data: Data?
    var error: Error?
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
    
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}

struct MockData: Codable, Equatable {
    var id: Int
    var name: String
}

final class NetworkingTests: XCTestCase {
    
    func testLoadDataCall() {
        let networkManager = ExtensionKit.Networking.NetworkManager()
        let session = NetworkSessionMock()
        networkManager.session = session
        let expectation = XCTestExpectation(description: "Load request is successful")
        let data = Data([0, 1, 1, 0])
        session.data = data
        let url = URL(fileURLWithPath: "url")
        networkManager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                XCTAssertEqual(data, returnedData, "HTTP Client returned unexpected data")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testSendDataCall() throws {
        let session = NetworkSessionMock()
        let manager = ExtensionKit.Networking.NetworkManager()
        let sampleObject = MockData(id: 1, name: "John")
        let data = try JSONEncoder().encode(sampleObject)
        session.data = data
        manager.session = session
        let url = URL(fileURLWithPath: "url")
        let expectation = XCTestExpectation(description: "Send request is successful")
        manager.sendData(to: url, body: sampleObject) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                let decodedObject = try? JSONDecoder().decode(MockData.self, from: returnedData)
                XCTAssertEqual(decodedObject, sampleObject)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 1)
    }
}
