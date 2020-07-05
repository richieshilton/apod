//
//  ApodView.swift
//  APOD
//
//  Created by Richie Shilton on 4/7/20.
//

import SwiftUI

struct ApodView: View {
    
    @StateObject var viewModel = ApodViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                if let apod = viewModel.apod {
                    ScrollView {
                        APODImageView(apod: apod)
                            .frame(height: 300)
                        
                        Text("\(apod.explanation)\nDate: \(apod.date)")
                            .font(.caption)
                            .padding()
                    }
                } else {
                    VStack {
                        Spacer()
                        Text(viewModel.error?.localizedDescription ?? "... fetching ...")
                            .padding()
                        Spacer()
                    }
                }
            }.layoutPriority(1)
            
            HStack {
                DatePicker(selection: $viewModel.date, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date:")
                }
                Button("today") {
                    viewModel.date = Date()
                }.foregroundColor(.white)
            }
            .padding()
        }
    }
}

