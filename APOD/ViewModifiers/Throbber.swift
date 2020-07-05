//
//  Throbber.swift
//  APOD
//
//  Created by Richie Shilton on 4/7/20.
//

import SwiftUI

struct Throbber: ViewModifier {
    @State var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .opacity(self.isAnimating ? 0.6 : 1)
            .animation(Animation
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: true))
            .onAppear {
                self.isAnimating = true
            }
    }
}
