//
//  Networking.swift
//  
//
//  Created by Muhammad Hassan on 25/08/2022.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
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
        }
    }
}
