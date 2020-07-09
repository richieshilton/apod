//
//  API.swift
//  APOD
//
//  Created by Richie Shilton on 5/7/20.
//

import Foundation
import Combine

class API {
    
    private static let baseUrl = "https://api.nasa.gov/planetary/apod?api_key=Bgzkhzy9CsKaEDzOejuQA8WZWGasqcKWJlokcwbE&date="
    
    static func getAPOD(from date: Date) -> AnyPublisher<APOD, Error> {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        let url =  URL(string: "\(API.baseUrl)\(formatter.string(from: date))")!

        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    switch (response as! HTTPURLResponse).statusCode {
                    default: throw ServiceErrors.serverError((response as! HTTPURLResponse).statusCode)
                    }
                }
                return data
            }
            .decode(type: APOD.self, decoder: JSONDecoder())
            .receiveOnMain()
            .eraseToAnyPublisher()
    }
}
