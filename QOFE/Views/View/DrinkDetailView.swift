//
//  DrinkDetailView.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import SwiftUI
import ToastSwiftUI

struct DrinkDetailView: View {
    
    @State private var showingAlert = false
    @State private var showingLogin = false

    var drink: Drink
    
    @State private var isPresentingToast = false
    
    var body: some View {
        ZStack{
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image("ic_qofe_dark").ignoresSafeArea()
                }
            }
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                
                ZStack{
                    
                    VStack{
                        ZStack(alignment: .bottom){
                            
                            ZStack(alignment: .center){
//                                Image(systemName: "")
//                                    .data(url: (URL(string: drink.imageName)!))
//                                    .resizable()
//                                    .scaledToFit()
//                                    .padding(.bottom, 50)
//                                    .padding(.top, 20)
                                
                                CustomImageViewDetail(urlString: drink.imageName)

                            }.padding(50)
                             .background(Color("darkBrown"))
                             

                            
                            Rectangle()
                                .frame(height: 80)
                                .foregroundColor(.white)
                                .cornerRadius(20, corners: [.topLeft, .topRight])
                            
                            HStack(){
                                VStack(alignment: .leading){
                                    Text(drink.name)
                                        .foregroundColor(.black)
                                        .font(.title)
                                        .bold()
                                    
                                    Text("Rp. \(drink.price.clean)")
                                        .foregroundColor(.black)
                                        .font(.title2)
                                    

                                    
                                }
                                .padding([.leading, .top], 20)
                                
                                Spacer()
                            }// end of hstack
                            
                        }// end of zstack
                        .listRowInsets(EdgeInsets())
                        
                        Text(drink.description)
                            .foregroundColor(.black)
                            .font(.body)
                            .padding(15)
                                            
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                //                Button {
                //                    showingAlert.toggle()
                //                } label: {
                //                    Text("Add to Basket")
                //                }
                                OrderButton(showAlert: $showingAlert, showLogin: $showingLogin, drink: drink)
                                Spacer()
                            }
                            .padding([.top, .bottom], 30)
                        }
                        
                    }
                }
                
                
            }//end of ScrollView
            .edgesIgnoringSafeArea([.top, .bottom])
            .navigationBarHidden(false)
            .toast(isPresenting: $showingAlert, message: "Berhasil \nmenambahkan", icon: .success, textColor: Color("darkBrown"))
        }.background(Color.white)
        
        
        
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
    @Binding var showLogin : Bool

    var drink: Drink
    
    var body: some View{
        
        Button(action: {
            
            if FUser.currentUser() != nil &&
                FUser.currentUser()!.onBoarding{
                self.showAlert.toggle()
                self.addItemtoBasket()
            }else{
                self.showLogin.toggle()
            }

        }){
            Text("Masukan Keranjang")
                .foregroundColor(Color.white)
                .frame(width: UIScreen.main.bounds.width - 100)
                .padding()
                .font(.subheadline)
        }
        .cornerRadius(10)
        .frame(height: 45)
        .background(Color("brown"))
        .clipShape(Capsule())
        .padding(.top, 50)
        .sheet(isPresented: self.$showLogin){
            if FUser.currentUser() != nil {
                FinishRegistrationView()
            }else{
                LoginView()
            }
        }
    }
    
    private func addItemtoBasket(){
        
        var orderBasket: OrderBasket!
        
        if self.basketListener.orderBasket != nil{
            orderBasket = self.basketListener.orderBasket
        }else{
            
            orderBasket = OrderBasket()
            orderBasket.ownerId = FUser.currentId()
            orderBasket.id = UUID().uuidString
            
        }
        
        orderBasket.add(self.drink)
        orderBasket.saveBasketToFirestore()

        
    }
}
