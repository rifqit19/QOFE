//
//  OrderBasketView.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import SwiftUI

struct OrderBasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        
        VStack{
            HStack{
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward.circle.fill")
                         .frame(width: 24,height: 24)
                         .foregroundColor(.black)
                }
                Spacer()
            }.padding([.trailing,.leading], 20)
            NavigationView{
                
                List{
                    Section{
                        ForEach(self.basketListener.orderBasket?.items ?? []){
                            drink in
                            
                            HStack{
                                CustomImageViewBasket(urlString: drink.imageName)
                                    .background(Color("lightBrown"))
                                    .cornerRadius(10, corners: .allCorners)
                                VStack(alignment:.leading){
                                    Text(drink.name)
                                        .padding(.bottom, 4)
                                    Text("Rp. \(drink.price.clean)")
                                    Spacer()
                                }.padding()
                            }// end of hstack
                            
                        }//end of foreach
                        .onDelete { indexSet in
                            self.deleteItems(at: indexSet)
                        }
                    }
                    
                    
                    Section{
                        NavigationLink(destination: CheckoutView()){
                            Text("Place Order")
                        }
                    }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
                    
                }//end of list
                .navigationBarTitle("Order")
                .listStyle(GroupedListStyle())
                
            }//end of navigationview
        }
    }
    
    func deleteItems(at offsets: IndexSet){
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}
