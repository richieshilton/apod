//
//  Date+Extended.swift
//  APOD
//
//  Created by Richie Shilton on 10/7/20.
//

import Foundation

extension Date {
    
    // Date in UTC/GMT
    static var utc: Date {
        let date = Date()
        let seconds = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        return Date(timeInterval: -seconds, since: date)
    }
}
