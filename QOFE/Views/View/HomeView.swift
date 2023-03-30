//
//  ContentView.swift
//  QOFE
//
//  Created by rifqitriginandri on 04/03/23.
//

import SwiftUI
import Foundation

struct HomeView: View {
    
    @ObservedObject var drinkListener = DrinkListener()
    @State private var showingBasket = false
    
    var categories: [String : [Drink]]{
        .init(grouping: drinkListener.drinks, by: {$0.category.rawValue})
    }
    
    var body: some View {
        
        NavigationView{
            
            List(categories.keys.sorted(), id: \String.self){
                key in
                
                DrinkRow(categoryname: "\(key) Drink".uppercased(), drinks: self.categories[key]!)
                    .padding(.top)
                    .padding(.bottom)
                
            }
            
                .navigationBarTitle(Text("QOFFE"))
                .navigationBarItems(
                    leading:
                        Button(action: {
                            //code
                            FUser.logoutCurrentUser { error in
                                print("error loging out user, ", error?.localizedDescription)
                            }
                        }, label: {
                            Text("Logout")
                        })
                    
                    
                    ,trailing:
                        Button(action: {
                            //code
                            self.showingBasket.toggle()
                        }, label: {
                            Image("basket").foregroundColor(.blue)
                        })
                        .sheet(isPresented: $showingBasket){
                            if FUser.currentUser() != nil &&
                                FUser.currentUser()!.onBoarding{
                                OrderBasketView()
                            }else if FUser.currentUser() != nil {
                                FinishRegistrationView()
                            }else{
                                LoginView()
                            }
                        }
                )
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
