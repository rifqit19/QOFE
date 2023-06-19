//
//  CheckoutView.swift
//  QOFE
//
//  Created by rifqitriginandri on 05/03/23.
//

import SwiftUI
import ToastSwiftUI

struct CheckoutView: View {
    
    @ObservedObject var basketListener = BasketListener()
    @Environment(\.presentationMode) var presentationMode
    
    static let paymentTypes = ["Tunai", "Kartu Kredit"]
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
        
        ZStack{
            
            Color.white
            
            BasketBgView()
            
            VStack{
                
                ZStack{
                    
                    HStack{
                        Spacer()
                        Text("Checkout")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Spacer()
                        
                    }
                    HStack{
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("back_black")
                                 .frame(width: 24,height: 24)
                                 .foregroundColor(.black)
                        }
                        Spacer()
                        
                    }.padding([.trailing,.leading], 20)
                }
                
                
                VStack{
                    HStack{
                        Text("Pilih pembayaran")
                            .foregroundColor(.white)
                            .padding(.leading, 5)
                        Spacer()
                        Picker(selection: $paymentType, label: Text("").foregroundColor(.black)){
                            ForEach(0 ..< Self.paymentTypes.count){
                                Text(Self.paymentTypes[$0])
                                    .foregroundColor(.black)
                            }
                        }

                    }.padding(10)
                        .background(Color("brown"))
                        .cornerRadius(10 , corners: .allCorners)
                        .shadow(radius: 10)


                    HStack{
                        Text("Tambah tip?")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.leading, 5)
                        
                        Spacer()
                    }.padding(.top)

                    Picker(selection: $tipAmount, label: Text("Persentage: ")){
                        ForEach(0 ..< Self.tipAmounts.count){
                            Text("\(Self.tipAmounts[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("brown"), lineWidth: 2)
                    )
                    
                    
                    HStack{
                        Text("Total: Rp. \(totalPrice, specifier: "%.2f")")
                            .font(.title2)
                            .padding(.top)
                        Spacer()
                    }
                }
                .padding()
                
                Spacer()

                Button(action: {
                    self.showingPaymentAlert.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.createOrder()
                        self.emptyBasket()
                    }
                    
                }){
                    Text("Lanjutkan")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                        .padding()
                        .font(.subheadline)

                }
                .frame(height: 45)
                .background(Color("darkBrown"))
                .clipShape(Capsule())
                .padding(.top, 50)
                
                

            }
            .toast(isPresenting: $showingPaymentAlert, message: "Berhasil \nmenambahkan", icon: .success, textColor: Color("darkBrown"))
            
//            Form{
//                Section{
//                }
//
//                Section(header: Text("Add a tip?")){
//                }
//
//                Section(header: Text("Total: $ \(totalPrice, specifier: "%.2f")").font(.largeTitle)){
//                    Button(action: {
//                        self.showingPaymentAlert.toggle()
//                        self.createOrder()
//                        self.emptyBasket()
//
//                    }){
//                        Text("Confirm Order")
//                    }
//                }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
//
//            }
//            .navigationBarTitle(Text("Payment"), displayMode: .inline)
            
        }
    }
    
    private func createOrder(){
        let order = Order()
        
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerId = FUser.currentId()
        order.customerName = FUser.currentUser()?.fullName
        order.orderItems = self.basketListener.orderBasket.items
        order.saveOrderToFirestore()
        
        presentationMode.wrappedValue.dismiss()
        
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
