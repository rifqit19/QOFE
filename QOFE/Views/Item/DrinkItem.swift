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
                
                Image(systemName: "")
                    .data(url: (URL(string: drink.imageName)!))
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .frame(width: 300, height: 170)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            
            
            
            VStack(alignment: .leading, spacing: 5){
                Text(drink.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(drink.description)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(height: 40)
            }
        }
    }
}

struct DrinkItem_Previews: PreviewProvider {
    static var previews: some View {
        DrinkItem(drink: drinkData[0])
    }
}
