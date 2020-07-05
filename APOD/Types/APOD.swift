//
//  APOD.swift
//  APOD
//
//  Created by Richie Shilton on 4/7/20.
//

import Foundation

struct APOD: Codable {
    let url: String
    let title: String
    let explanation: String
    
    var isVideo: Bool {
        return url.contains("youtube")
    }
}
