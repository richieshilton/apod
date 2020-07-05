//
//  ImageUrlView.swift
//  APOD
//
//  Created by Richie Shilton on 4/7/20.
//

import SwiftUI

struct ImageUrlView: View {
    
    @ObservedObject var remoteImageModel: RemoteImageModel
    
    init(url: String?) {
        remoteImageModel = RemoteImageModel(imageUrl: url)
    }
    
    var body: some View {
        return ZStack {
            if let _ = remoteImageModel.imageUrl,
               remoteImageModel.displayImage == nil {
                Color.gray
                    .modifier(Throbber())
            }
            
            if let image = remoteImageModel.displayImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
