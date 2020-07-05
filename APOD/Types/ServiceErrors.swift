//
//  ServiceErrors.swift
//  APOD
//
//  Created by Richie Shilton on 4/7/20.
//

import Foundation

enum ServiceErrors: Error {
    case serverError(_ statusCode: Int)
}
