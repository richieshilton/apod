//
//  Publisher+Extended.swift
//  APOD
//
//  Created by Richie Shilton on 8/7/20.
//

import Foundation
import Combine

extension Publisher {
    
    public func mapToVoid() -> Publishers.Map<Self, Void> {
        return map { _ in () }
    }
    
    public func assignErrors<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Self.Failure?>, on object: Root) -> AnyPublisher<Self.Output, Never> {
        
        mapError { [weak object] error -> Failure in
            object?[keyPath: keyPath] = error
            return error
        }
        .ignoreErrors()
    }
    
    public func ignoreErrors() -> AnyPublisher<Self.Output, Never>{
        
        self.catch { _ -> Empty<Self.Output, Never> in
            return Empty<Self.Output, Never>()
        }
        .eraseToAnyPublisher()
    }
    
    public func receiveOnMain() -> Publishers.ReceiveOn<Self, RunLoop> {
        receive(on: RunLoop.main)
    }
    
    public func withLatestFrom<P>(_ other: P) -> AnyPublisher<(Self.Output, P.Output), Self.Failure> where P: Publisher, Self.Output: Equatable, Self.Failure == P.Failure {
        
        return flatMap { first in
            other.map { second in
                return (first, second)
            }
        }.eraseToAnyPublisher()
    }
}

extension Publisher where Self.Failure == Never {
    
    /// - Note: This is an overload of the existing `assign(to:on:)` which adds an `AnyObject` constraint on `Root` in
    /// order to capture the value weakly. Without it, using this method would leak memory. Additionally, it writes to
    /// an `Optional` value, preventing type issues between `Optional` and non-`Optional` values.
    func assign<Root: AnyObject>(to path: ReferenceWritableKeyPath<Root, Output?>, on root: Root) -> AnyCancellable {

        sink { [weak root] in
            root?[keyPath: path] = $0
        }
    }
}
