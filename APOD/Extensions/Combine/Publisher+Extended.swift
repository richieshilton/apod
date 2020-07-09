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
    
    public func trackErrors<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Self.Failure?>, on object: Root) -> AnyPublisher<Self.Output, Never> {
        self.catch { [weak object] error -> Empty<Self.Output, Never> in
            object?[keyPath: keyPath] = error
            return Empty<Self.Output, Never>()
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Self.Failure == Never {
    
    /// Assigns a `Publisher`'s `Output` to a property of an object.
    ///
    /// - Note: This is an overload of the existing `assign(to:on:)` which adds an `AnyObject` constraint on `Root` in
    /// order to capture the value weakly. Without it, using this method would leak memory. Additionally, it writes to
    /// an `Optional` value, preventing type issues between `Optional` and non-`Optional` values.
    ///
    /// - Parameters:
    ///   - path:  `ReferenceWritableKeyPath` indicating the property to assign.
    ///   - root:  Instance that contains the property.
    /// - Returns: `AnyCancellable` instance.
    func assign<Root: AnyObject>(to path: ReferenceWritableKeyPath<Root, Output?>, on root: Root) -> AnyCancellable {

        sink { [weak root] in root?[keyPath: path] = $0 }
    }
}
