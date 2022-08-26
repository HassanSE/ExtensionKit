//
//  Networking.swift
//  
//
//  Created by Muhammad Hassan on 25/08/2022.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
    
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        dataTask(with: request) { data, _, error in
            completionHandler(data, error)
        }.resume()
    }
}

extension ExtensionKit {
    enum NetworkError: Error {
        case unknown
    }
    
    public class Networking {
        
        /// Responsible for handling all networking calls
        ///  - Warning: Must create before using any public APIs
        public class NetworkManager {
            
            public init() {}
            internal var session: NetworkSession = URLSession.shared
            
            /// Calls to the live internet to retrieve data from a given URL
            /// - Parameters:
            ///   - url: The location you wish to fetch data from
            ///   - completionHandler: Returns a result object which signifies the status of the request
            public func loadData(from url: URL,
                                 completionHandler: @escaping (Result<Data, Error>) -> Void) {
                session.get(from: url) { data, error in
                    let result = data.map(Result<Data, Error>.success) ?? .failure(error ?? NetworkError.unknown)
                    completionHandler(result)
                }
            }
            
            
            /// Calls to the live internet to send data to a specific location
            /// - Warning: Make sure that the URL in question can accept a POST route
            /// - Parameters:
            ///   - url: The location you wish to send data to
            ///   - body: The object you wish to send over the network
            ///   - completionHandler: Returns a result object which signifies the status of the request
            public func sendData<I: Codable>(to url: URL,
                                             body: I,
                                             completionHandler: @escaping (Result<Data, Error>) -> Void) {
                var request = URLRequest(url: url)
                do {
                    let httpBody = try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    request.httpMethod = "POST"
                    session.post(with: request) { data, error in
                        let result = data.map(Result<Data, Error>.success) ?? .failure(error ?? NetworkError.unknown)
                        completionHandler(result)
                    }
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}
