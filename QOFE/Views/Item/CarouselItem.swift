//
//  CarouselItem.swift
//  QOFE
//
//  Created by rifqi triginandri on 04/06/23.
//

import SwiftUI

struct CarouselItem: View {
    var body: some View{
            Rectangle()
                .fill(Color.pink)
                .frame(height: 200)
                .border(Color.black)
                .padding()
                .edgesIgnoringSafeArea([.leading, .trailing])
        }
}

struct CarouselItem_Previews: PreviewProvider {
    static var previews: some View {
        CarouselItem()
    }
}
