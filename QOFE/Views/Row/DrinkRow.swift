//
//  DrinkRow.swift
//  QOFE
//
//  Created by rifqitriginandri on 04/03/23.
//

import SwiftUI

struct DrinkRow: View {
    
    var categoryname: String
    var drinks: [Drink]
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(self.categoryname)
                .font(.title2)
                .bold()
                .foregroundColor(self.categoryname == "Cold" ? .white : .black)
                .shadow(radius: 10)
                .padding(.leading, 20)
            
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack{
                    ForEach(drinks) { drink in
                        
                        NavigationLink(destination: DrinkDetailView(drink: drink)){
                            
                            DrinkItem(drink: drink)
                                .frame(width: 200)
                                .padding(.trailing, 20)
                                .padding(.leading, 10)
                            
                        }
                        
                    }
                }.padding(35)
            }.padding(-20)
            
            
        }
        
    }
}

struct DrinkRow_Previews: PreviewProvider {
    static var previews: some View {
        DrinkRow(categoryname: "Hot Drinks", drinks: drinkData)
    }
}
