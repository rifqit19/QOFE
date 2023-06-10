//
//  CheckoutView.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    static let paymentTypes = ["Cash", "Credit Card"]
    static let tipAmounts = [0, 5, 10, 15]
    
    @State private var paymentType = 0
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false
    
    var totalPrice: Double{
        if let total = basketListener.orderBasket?.total {
            // Use the total value here
            let tipValue = total / 1000 * Double(Self.tipAmounts[tipAmount])
            return total + tipValue
        } else {
            // Handle the case when the total is nil
            return 0.0

        }
    }
    
    var body: some View {
        Form{
            Section{
                Picker(selection: $paymentType, label: Text("How do you want to pay?")){
                    ForEach(0 ..< Self.paymentTypes.count){
                        Text(Self.paymentTypes[$0])
                    }
                }
            }
            
            Section(header: Text("Add a tip?")){
                Picker(selection: $tipAmount, label: Text("Persentage: ")){
                    ForEach(0 ..< Self.tipAmounts.count){
                        Text("\(Self.tipAmounts[$0]) %")
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(5)
            }
            
            Section(header: Text("Total: $ \(totalPrice, specifier: "%.2f")").font(.largeTitle)){
                Button(action: {
                    self.showingPaymentAlert.toggle()
                    self.createOrder()
                    self.emptyBasket()
                    
                }){
                    Text("Confirm Order")
                }
            }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
                
        }
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert) {
            
            Alert(title: Text("Order confirm"), message: Text("Thank You!"), dismissButton: .default(Text("OK")))
        }
    }
    
    private func createOrder(){
        let order = Order()
        
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerId = FUser.currentId()
        order.orderItems = self.basketListener.orderBasket.items
        order.saveOrderToFirestore()
        
    }
    
    private func emptyBasket(){
        self.basketListener.orderBasket.emptybasket()
    }

}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
