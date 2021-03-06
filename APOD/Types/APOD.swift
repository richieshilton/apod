//
//  APOD.swift
//  APOD
//
//  Created by Richie Shilton on 4/7/20.
//

import Foundation

struct APOD: Codable, Equatable {
    
    let url: String
    let title: String
    let explanation: String
    let date: String
    
    var isVideo: Bool {
        return url.contains("youtube")
    }
}
