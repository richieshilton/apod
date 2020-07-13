//
//  Date+Extended.swift
//  APOD
//
//  Created by Richie Shilton on 10/7/20.
//

import Foundation

extension Date {
    
    // Date in EST time
    static var est: Date {
        let localDiff = TimeZone.current.secondsFromGMT()
        let estDiff = TimeZone(abbreviation: "EST")?.secondsFromGMT() ?? (5 * 60 * 60)
        return Date(timeInterval: TimeInterval(estDiff - localDiff), since: Date())
    }
}
