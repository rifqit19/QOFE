//
//  ImageCarouselView.swift
//  QOFE
//
//  Created by rifqi triginandri on 04/06/23.
//

import SwiftUI

struct ImageCarouselView: View {
    
    // 1
    private let images = ["americano", "decaf", "latte", "frappe"]
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var index = 0
    @State private var selectedNum: String = ""

    var body: some View {
        // 2
        TabView {
            ForEach(images, id: \.self) { item in
                 //3
                 Image(item)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
                    
                    .onReceive(timer, perform: { _ in
                        withAnimation {
                            index = index < images.count ? index + 1 : 1
                            selectedNum = images[index - 1]
                        }
                    })
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        // 4
        ImageCarouselView()
            .previewLayout(.fixed( width: 300, height: 150))
    }
}
