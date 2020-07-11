//
//  ApodViewModel.swift
//  APOD
//
//  Created by Richie Shilton on 4/7/20.
//

import Foundation
import Combine
import SwiftUI

class ApodViewModel: ObservableObject {
    
    // State
    @Published var date: Date = .utc
    
    // Outputs
    @Published var apod: APOD?
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
            
        let willEnterForeground = NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .mapToVoid()
            .prepend(())
        
        
        let update = Publishers
            .combineLatest($date, willEnterForeground) { (date, _) in date }
            
            
        update
            .flatMap {
                API().getAPOD(from: $0)
                    .assignErrors(to: \.error, on: self)
            }
            .removeDuplicates()
            .assign(to: \.apod, on: self)
            .store(in: &cancellables)
    }
}
