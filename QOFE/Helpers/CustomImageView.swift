//
//  CustomImageView.swift
//  QOFE
//
//  Created by rifqi triginandri on 03/06/23.
//

import Foundation
import SwiftUI

struct CustomImageView: View {
    var urlString: String
    @ObservedObject var imageLoader = ImageLoader()
    @State var image: UIImage = UIImage()
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 170)
            .shadow(radius: 10)
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(for: urlString)
            }
    }
}

struct CustomImageViewDetail: View {
    var urlString: String
    @ObservedObject var imageLoader = ImageLoader()
    @State var image: UIImage = UIImage()
    
    var body: some View {
        
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .padding(.bottom, 50)
            .padding(.top, 20)
            .shadow(radius: 10)
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(for: urlString)
            }
    }
}


struct CustomImageViewBasket: View {
    var urlString: String
    @ObservedObject var imageLoader = ImageLoader()
    @State var image: UIImage = UIImage()
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .padding()
            .shadow(radius: 10)
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(for: urlString)
            }
    }
}
