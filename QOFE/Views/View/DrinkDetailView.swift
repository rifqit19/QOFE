//
//  DrinkDetailView.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import SwiftUI

struct DrinkDetailView: View {
    
    @State private var showingAlert = false
    
    var drink: Drink
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            ZStack(alignment: .bottom){
                
                Image(drink.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                
                HStack(){
                    VStack(alignment: .leading, spacing: 8){
                        Text(drink.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    
                    Spacer()
                }// end of hstack
                
            }// end of zstack
            .listRowInsets(EdgeInsets())
            
            Text(drink.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            
            HStack{
                Spacer()
//                Button {
//                    showingAlert.toggle()
//                } label: {
//                    Text("Add to Basket")
//                }
                OrderButton(showAlert: $showingAlert, drink: drink)
                Spacer()
            }
            .padding(.top, 50)
            
        }//end of ScrollView
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(false)
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Added to Basket!"), dismissButton: .default(Text("OK")))
        }
        
    }
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailView(drink: drinkData[0])
    }
}


struct OrderButton: View{
    
    @ObservedObject var basketListener = BasketListener()
    @Binding var showAlert : Bool
    
    var drink: Drink
    
    var body: some View{
        
        Button(action: {
            self.showAlert.toggle()
            self.addItemtoBasket()
        }){
            Text("Add to basket")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
    }
    
    private func addItemtoBasket(){
        
        var orderBasket: OrderBasket!
        
        if self.basketListener.orderBasket != nil{
            orderBasket = self.basketListener.orderBasket
        }else{
            
            orderBasket = OrderBasket()
            orderBasket.ownerId = "123"
            orderBasket.id = UUID().uuidString
            
        }
        
        orderBasket.add(self.drink)
        orderBasket.saveBasketToFirestore()

        
    }
}
