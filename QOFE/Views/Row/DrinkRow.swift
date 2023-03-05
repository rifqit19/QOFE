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
                .font(.title)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack{
                    ForEach(drinks) { drink in
                        
                        NavigationLink(destination: DrinkDetailView(drink: drink)){
                            
                            DrinkItem(drink: drink)
                                .frame(width: 300)
                                .padding(.trailing, 30)
                            
                        }
                        
                    }
                }
            }
            
            
        }
        
    }
}

struct DrinkRow_Previews: PreviewProvider {
    static var previews: some View {
        DrinkRow(categoryname: "Hot Drinks", drinks: drinkData)
    }
}
