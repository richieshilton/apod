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
    @Published var date: Date = Date()
    
    // Outputs
    @Published var apod: APOD?
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        $date
            .flatMap { API.getAPOD(from: $0) }
            .catch { error -> Empty<APOD, Never> in
                self.error = error
                return Empty(completeImmediately: false)
            }
            .compactMap { $0 }
            .assign(to: \.apod, on: self)
            .store(in: &cancellables)
    }
}