//
//  APODImageView.swift
//  APOD
//
//  Created by Richie Shilton on 5/7/20.
//

import SwiftUI

struct APODImageView: View {
    
    let apod: APOD
    var body: some View {
        
        GeometryReader { geometry in
            let shrinking = geometry.frame(in: .global).minY <= 0
            let height = shrinking ? geometry.size.height : geometry.size.height + geometry.frame(in: .global).minY
            let offset = shrinking ? geometry.frame(in: .global).minY/9 : -geometry.frame(in: .global).minY
            let blur: CGFloat = shrinking ? -offset / 5 : 0
            
            ZStack {
                ImageUrlView(url: apod.url)
                    .frame(width: geometry.size.width, height: height)
                    .clipped()
                    .offset(y: offset)
                    .blur(radius: blur)
            }
            
            VStack {
                if apod.isVideo,
                   let url = URL(string: apod.url) {
                    Link(destination: url) {
                        HStack {
                            Image(systemName: "link.circle.fill")
                            Text("Video not yet supported,\ntap here to view outside the app")
                                .font(.caption2)
                            Spacer()
                        }.foregroundColor(.white)
                    }
                }
                Spacer()
                Text(apod.title)
                    .font(.title)
                    .foregroundColor(.white)
            }.padding()
        }
    }
}
