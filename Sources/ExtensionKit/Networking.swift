//
//  Networking.swift
//  
//
//  Created by Muhammad Hassan on 25/08/2022.
//

import Foundation

extension ExtensionKit {
    enum NetworkError: Error {
        case unknown
    }
    
    public class Networking {
        
        /// Responsible for handling all networking calls
        ///  - Warning: Must create before using any public APIs
        public class HTTPClient {
            
            public init() {}
            private let session = URLSession.shared
            
            public func loadData(from url: URL,
                                 completionHandler: @escaping (Result<Data, Error>) -> Void) {
                let task = session.dataTask(with: url) { data, response, error in
                    let result = data.map(Result<Data, Error>.success) ?? .failure(error ?? NetworkError.unknown)
                    completionHandler(result)
                }
                task.resume()
            }
        }
    }
}
