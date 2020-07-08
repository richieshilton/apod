//
//  Publisher+Extended.swift
//  APOD
//
//  Created by Richie Shilton on 8/7/20.
//

import Combine

extension Publisher {
    
    func mapToVoid() -> AnyPublisher<Void, Failure> {
        map { _ in () }
            .eraseToAnyPublisher()
    }
    
    public func trackErrors<T>(to keyPath: ReferenceWritableKeyPath<T, Self.Failure?>, on object: T) -> AnyPublisher<Self.Output, Never>  {
        self.catch {  error -> Empty<Self.Output, Never> in
            object[keyPath: keyPath] = error
            return Empty<Self.Output, Never>()
        }
        .eraseToAnyPublisher()
    }
}
