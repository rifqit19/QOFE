//
//  BasketListener.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import Foundation
import SwiftUI

class BasketListener: ObservableObject{
    
    @Published var orderBasket: OrderBasket!
    
    init(){
        downloadBasket()
    }
    
    func downloadBasket(){
        FirebaseReference(.Basket).whereField(kOWNERID, isEqualTo: "123").addSnapshotListener { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            if !snapshot.isEmpty {
                let basketData = snapshot.documents.first!.data()
                
                getDrinksFromFirestore(withIds: basketData[kDRINKSID] as? [String] ?? []) { allDrinks in
                    
                    let basket = OrderBasket()
                    basket.ownerId = basketData[kOWNERID] as? String
                    basket.id =  basketData[kID] as? String
                    basket.items = allDrinks
                    self.orderBasket = basket
                }
            }
        }
    }
}


func getDrinksFromFirestore(withIds: [String], completion: @escaping (_ drinkArray: [Drink]) -> Void){
    
    var count = 0
    var drinkArray: [Drink] = []
    
    if withIds.count == 0{
        completion(drinkArray)
        return
    }
    
    for drinkId in withIds{
        
        FirebaseReference(.Menu).whereField(kID, isEqualTo: drinkId).getDocuments { snapshot, error in
            guard let snapshot = snapshot else{return}
            
            if !snapshot.isEmpty{
                let drinkData = snapshot.documents.first!
                
                drinkArray.append(Drink(
                    id: drinkData[kID] as? String ?? UUID().uuidString,
                    name: drinkData[kNAME] as? String ?? "Unknown",
                    imageName: drinkData[kIMAGENAME] as? String ?? "Unknown",
                    category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "cold") ?? .cold,
                    description: drinkData[kDESCRIPTION] as? String ?? "Description not found",
                    price: drinkData[kPRICE] as? Double ?? 0.0))
                
                count += 1
                
            }else{
                print("have no drink")
                completion(drinkArray)
            }
            
            if count == withIds.count{
                completion(drinkArray)
            }
        }

    }
    
}
