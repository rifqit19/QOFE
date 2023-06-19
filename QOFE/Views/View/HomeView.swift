//
//  ContentView.swift
//  QOFE
//
//  Created by rifqitriginandri on 04/03/23.
//

import SwiftUI
import Foundation
import Combine
import ToastSwiftUI


struct HomeView: View {
    
    @ObservedObject var drinkListener = DrinkListener()
    @State private var showingBasket = false
    @State private var showingProfil = false

    private var numberOfImages = 4
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0

    
    var categories: [String : [Drink]]{
        .init(grouping: drinkListener.drinks, by: {$0.category.rawValue})
    }
    
    @State private var showingAlert = false
    @State private var toastMessage: String?
    
    @State private var name = FUser.currentUser() != nil ? FUser.currentUser()?.fullName ?? "kamu..." : "kamu belum login"
    
    @State private var showDialog = false


    var body: some View {
        
        NavigationView(){
            ZStack{
                BGView()
                
                VStack{
                    
                    HStack{
                        Button {
                            
                                self.showingProfil.toggle()
                            
                        } label: {
                            Image(systemName: "person.circle.fill")
                                 .frame(width: 35,height: 24)
                                 .foregroundColor(.white)
                                 .scaledToFill()
                                 
                        }.fullScreenCover(isPresented: $showingProfil){
                            if FUser.currentUser() != nil {
                                DetailProfilView().onDisappear(){
                                    name = FUser.currentUser() != nil ? FUser.currentUser()?.fullName ?? "kamu..." : "kamu belum login"
                                }
                            }else{
                                LoginView().onDisappear(){
                                    name = FUser.currentUser() != nil ? FUser.currentUser()?.fullName ?? "kamu..." : "kamu belum login"
                                }
                            }
                        }
                        
                        Text("Hai, \(name)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .onAppear(){
                                name = FUser.currentUser() != nil ? FUser.currentUser()?.fullName ?? "kamu..." : "kamu belum login"
                            }
                        
                        Spacer()
                        Button {
                            self.showingBasket.toggle()

                        } label: {
                            Image(systemName: "cart.fill")
                                 .frame(width: 35,height: 24)
                                 .foregroundColor(.white)
                                 .scaledToFill()
                        }.fullScreenCover(isPresented: $showingBasket){
                            if FUser.currentUser() != nil &&
                                FUser.currentUser()!.onBoarding{
                                OrderBasketView()
                            }else if FUser.currentUser() != nil {
                                FinishRegistrationView().onDisappear(){
                                    name = FUser.currentUser() != nil ? FUser.currentUser()?.fullName ?? "kamu..." : "kamu belum login"
                                }
                            }else{
                                LoginView().onDisappear(){
                                    name = FUser.currentUser() != nil ? FUser.currentUser()?.fullName ?? "kamu..." : "kamu belum login"
                                }
                            }
                        }

                    }//end of hstack
                    .padding([.trailing,.leading], 20)
                        .padding([.top, ], 10)
                        .padding([.leading, .trailing], 5)

                    ScrollView{
                        
                        VStack(alignment: .leading){
                                TabView(selection: $currentIndex){
                                    ForEach(0..<numberOfImages){ num in
                                        
                                        Image("\(num)")
                                            .resizable()
                                            .scaledToFill()
                                            .tag(num)
                                    }
                                }.tabViewStyle(PageTabViewStyle())
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding([.leading, .trailing], 20)
                                    .shadow(radius: 10)
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 2.5)
                                    .onReceive(timer) { _ in
                                        withAnimation{
                                            currentIndex = currentIndex < numberOfImages ? currentIndex + 1 : 0
                                        }
                                    }
                            ForEach(categories.keys.sorted(), id: \String.self){ key in
                                DrinkRow(categoryname: "\(key)".capitalized, drinks: self.categories[key]!)
                                    .padding(.top)
                                    .padding(.bottom)
                            }
                        }.padding(.all)
                    } // end off scrollview
                    .clipped()
                    .edgesIgnoringSafeArea(.bottom)
                    
                }
            }.background(Color.white)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct BGView: View{
    
    
    var body: some View{
        
        VStack(){
            ZStack(alignment: .top){
                Image("elips_login")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .background(
                    Image("elips_login").resizable()
                ).ignoresSafeArea()
                
            }
                        
            Spacer()
            
            HStack{
                Spacer()
                Image("ic_qofe_dark").ignoresSafeArea()
            }
            
        }//end of vstack
        .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
    }
}
