//
//  ContentView.swift
//  QOFE
//
//  Created by rifqitriginandri on 04/03/23.
//

import SwiftUI
import Foundation
import Combine


struct HomeView: View {
    
    @ObservedObject var drinkListener = DrinkListener()
    @State private var showingBasket = false
    
    
    var categories: [String : [Drink]]{
        .init(grouping: drinkListener.drinks, by: {$0.category.rawValue})
    }
    
    

    var body: some View {
        
        NavigationView(){
            ZStack{
                BGView()
                
                VStack{
                    
                    HStack{
                        Button {
                            FUser.logoutCurrentUser { error in
                                print("error loging out user, ", error?.localizedDescription)
                            }
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                 .frame(width: 35,height: 24)
                                 .foregroundColor(.white)
                                 .scaledToFill()
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
                                FinishRegistrationView()
                            }else{
                                LoginView()
                            }
                        }

                        Button {

                        } label: {
                            Image(systemName: "person.circle.fill")
                                 .frame(width: 35,height: 24)
                                 .foregroundColor(.white)
                                 .scaledToFill()
                        }
                    }.padding([.trailing,.leading], 20)
                        .padding([.top], 10)

                    ScrollView{
                        
                        VStack(alignment: .leading){
                            
                                ScrollView(.horizontal){
                                                ImageCarouselView()
                                        .frame(width: UIScreen.main.bounds.width-30, height: UIScreen.main.bounds.height / 4.5)
                                                    .cornerRadius(20, corners: .allCorners)
                                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                            }
                                        
                                
                                        
                            
                            ForEach(categories.keys.sorted(), id: \String.self){
                                key in

                                
                                DrinkRow(categoryname: "\(key)".capitalized, drinks: self.categories[key]!)
                                    .padding(.top)
                                    .padding(.bottom)


                            }
                        }.padding(.all)
                        }
                }
            }.background(Color.white)

        }


//            NavigationView{
//
//
//                    .navigationBarTitle(Text("QOFE"))
//                    .navigationBarItems(
//                        leading:
//                            Button(action: {
//                                //code
//                                FUser.logoutCurrentUser { error in
//                                    print("error loging out user, ", error?.localizedDescription)
//                                }
//                            }, label: {
//                                Text("Logout")
//                            })
//
//
//                        ,trailing:
//                            Button(action: {
//                                //code
//                                self.showingBasket.toggle()
//                            }, label: {
//                                Image("basket").foregroundColor(.blue)
//                            })
//                            .fullScreenCover(isPresented: $showingBasket){
//                                if FUser.currentUser() != nil &&
//                                    FUser.currentUser()!.onBoarding{
//                                    OrderBasketView()
//                                }else if FUser.currentUser() != nil {
//                                    FinishRegistrationView()
//                                }else{
//                                    LoginView()
//                                }
//                            }
//                    )
//                    .blendMode(.darken)
//
//            }.background(Color.red)
    }}

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


struct CarouselView: View{
    @State private var index = 0

    var body: some View {
            VStack{
                TabView(selection: $index) {
                    ForEach((0..<3), id: \.self) { index in
                        CarouselItem()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 2) {
                    ForEach((0..<3), id: \.self) { index in
                        Circle()
                            .fill(index == self.index ? Color.white : Color.white.opacity(0.5))
                            .frame(width: 8, height: 8)

                    }
                }
                .padding([.leading, .trailing, .bottom])
               
                
                
            }
            .frame(height: 180)
        }
}
