//
//  DrinkItem.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import SwiftUI

struct DrinkItem: View {
    
    var drink: Drink
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            
            ZStack(alignment: .center){
                ProgressView()
                
//                Image(systemName: "")
//                    .data(url: (URL(string: drink.imageName)!))
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 150, height: 170)
//                    .shadow(radius: 10)
                
                CustomImageView(urlString: drink.imageName)
            }
            
            
            
            VStack(alignment: .leading, spacing: 2){
                Text(drink.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Rp. \(String(drink.price.clean))")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }.padding(.bottom, 10)
        }
        .frame(width: 180, height: 230)
        .padding(.all)
        .background(Color("brown"))
        .cornerRadius(20)

    }
}

struct DrinkItem_Previews: PreviewProvider {
    static var previews: some View {
        DrinkItem(drink: drinkData[0])
    }
}
