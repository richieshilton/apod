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
    
    private let session: URLSession
    
    init(session: URLSession = .default) {
        self.session = session
    }
    
    // Get's the APOD data for a givern date
    func getAPOD(from date: Date) -> AnyPublisher<APOD, Error> {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let url =  URL(string: "\(API.baseUrl)\(formatter.string(from: date))")!
        let request = URLRequest(url: url)
        
        return session.publisher(from: request)
    }
}
