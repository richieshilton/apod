//
//  Publishers+Extended.swift
//  APOD
//
//  Created by Richie Shilton on 9/7/20.
//

import Combine

extension Publishers {
    
    public static func combineLatest<T, P, U>(_ first: T, _ other: P, _ transform: @escaping (T.Output, P.Output) -> U) -> Publishers.Map<Publishers.CombineLatest<T, P>, U> where T: Publisher, P : Publisher, T.Failure == P.Failure {
        
        return first.combineLatest(other, transform)
    }
}
