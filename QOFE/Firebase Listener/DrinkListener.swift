//
//  DrinkListener.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class DrinkListener: ObservableObject{
    
    @Published var drinks: [Drink] = []
    
    init() {
        downloadDrinks()
    }
    
    func downloadDrinks() {
        FirebaseReference(.Menu).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else{ return }
            
            if !snapshot.isEmpty{
                self.drinks = DrinkListener.drinkFromDictionary(snapshot)
                
            }
        }
    }
    
    
    static func drinkFromDictionary(_ snapshot: QuerySnapshot) -> [Drink]{
        var allDrinks: [Drink] = []
        
        for snapshot in snapshot.documents{
            
            let drinkData = snapshot.data()
            
            allDrinks.append(Drink(
                id: drinkData[kID] as? String ?? UUID().uuidString,
                name: drinkData[kNAME] as? String ?? "Unknown",
                imageName: drinkData[kIMAGENAME] as? String ?? "Unknown",
                category: Category(rawValue: drinkData[kCATEGORY] as? String ?? "cold") ?? .cold,
                description: drinkData[kDESCRIPTION] as? String ?? "Description not found",
                price: drinkData[kPRICE] as? Double ?? 0.0))
            
        }
        
        return allDrinks
        
    }
}
