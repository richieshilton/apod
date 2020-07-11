//
//  URLSessionExtended.swift
//  APOD
//
//  Created by Richie Shilton on 10/7/20.
//

import Foundation
import Combine

extension URLSession {
    
    static var `default`: URLSession {
        return URLSession.shared
    }
    
    func publisher<T: Decodable>(from request: URLRequest) -> AnyPublisher<T, Error> {
        
        self.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    switch (response as! HTTPURLResponse).statusCode {
                    default: throw ServiceErrors.serverError((response as! HTTPURLResponse).statusCode)
                    }
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receiveOnMain()
            .eraseToAnyPublisher()
    }
}
