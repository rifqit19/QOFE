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
    
    @State private var showingCheckout = false


    
    var body: some View {
        
        ZStack{
            
            BasketBgView()

            VStack{
                ZStack{
                    
                    HStack{
                        Spacer()
                        Text("Keranjang")
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
                
                ZStack{
                    ScrollView{
                            ForEach(self.basketListener.orderBasket?.items ?? []){
                                drink in
                                
                                HStack(){
                                    CustomImageViewBasket(urlString: drink.imageName)
                                        .background(Color("lightBrown"))
                                        .cornerRadius(10, corners: .allCorners)
                                    VStack(alignment:.leading){
                                        Text(drink.name)
                                            .padding(.bottom, 4)
                                        Text("Rp. \(drink.price.clean)")
                                        Spacer()
                                    }.padding()
                                    
                                    Spacer()
                                }// end of hstack
                                .padding()
                                .mySwipeAction { // red + trash icon as default
                                    self.deleteItems(at: Int(drink.id) ?? 0000)
                                }
                                
                            }//end of foreach
                    }//end of list
                    .padding(.bottom, 70)
                    .clipped()
                    .edgesIgnoringSafeArea(.bottom)
                    
                    VStack{
                        Spacer()
                        
                        Button(action: {
                            self.basketListener.orderBasket.saveBasketToFirestore()
                            self.showingCheckout.toggle()

                        }, label: {
                            Text("Buat Pesanan")
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width - 170)
                                .padding()
                                .font(.subheadline)
                        })//end of button
                        .frame(height: 45)
                        .background(Color("darkBrown"))
                        .clipShape(Capsule())
                        .padding(.top, 50)
                        .disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
                        .fullScreenCover(isPresented: $showingCheckout){
                            CheckoutView()
                        }

                    }
                }
            }
        }
    }
    
    func deleteItems(at offsets: Int){
        self.basketListener.orderBasket.items.remove(at: offsets)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}


struct BasketBgView: View{
    
    var body: some View{
        
        VStack(){
            Spacer()
            
            HStack{
                Spacer()
                Image("ic_qofe_dark").ignoresSafeArea()
            }
            
        }//end of vstack
        .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
    }
}

extension View {
    func mySwipeAction(color: Color = .red,
                       icon: String = "trash",
                       action: @escaping () -> ()) -> some View {
        return self.modifier(MySwipeModifier(color: .red, icon: "trash", action: action ))
    }
}

struct MySwipeModifier: ViewModifier {
    
    let color: Color
    let icon: String
    let action: () -> ()
    
    @AppStorage("MySwipeActive") var mySwipeActive = false
    
    @State private var contentWidth: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var isDeleting: Bool = false
    @State private var isActive: Bool = false
    @State private var dragX: CGFloat = 0
    @State private var iconOffset: CGFloat = 40
    
    let miniumDistance: CGFloat = 20
    
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            
            content
                .overlay( GeometryReader { geo in Color.clear.onAppear { contentWidth = geo.size.width }})
                .offset(x: -dragX)
            
            Group {
                color
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .offset(x: isDeleting ? 40 - dragX/2 : iconOffset)
            }
            .frame(width: max(dragX, 0))
            // tap on red area after being active > action
            .onTapGesture {
                withAnimation { action() }
            }
            
        }
        .contentShape(Rectangle())
        
        // tap somewhere else > deactivate
        .onTapGesture {
            withAnimation {
                isActive = false
                dragX = 0
                iconOffset = 40
                mySwipeActive = false
            }
        }
        
        .gesture(DragGesture(minimumDistance: miniumDistance)
                 
            .onChanged { value in
                
                // if dragging started new > reset dragging state for all (others)
                if !isDragging && !isActive {
                    mySwipeActive = false
                    isDragging = true
                }
                
                if value.translation.width < 0 {
                    dragX = -min(value.translation.width + miniumDistance, 0)
                } else if isActive {
                    dragX = max(80 - value.translation.width + miniumDistance, -30)
                }
                
                iconOffset = dragX > 80 ? -40+dragX/2 : 40-dragX/2
                withAnimation(.easeOut(duration: 0.3)) { isDeleting = dragX > contentWidth*0.75 }
                
                // full drag > action
                if value.translation.width <= -contentWidth {
                    withAnimation { action() }
                    mySwipeActive = false
                    isDragging = false
                    isActive = false
                    return
                }
                
            }
                 
            .onEnded { value in
                withAnimation(.easeOut) {
                    isDragging = false
                    
                    // half drag > change to active / show icon
                    if value.translation.width < -60 && !isActive {
                        isActive = true
                        mySwipeActive = true
                    } else {
                        isActive = false
                        mySwipeActive = false
                    }
                    
                    // in delete mode > action
                    if isDeleting { action() ; return }
                    
                    // in active mode > show icon
                    if isActive {
                        dragX = 80
                        iconOffset = 0
                        return
                    }
                    
                    dragX = 0
                    isDeleting = false
                }
            }
        )
        
        // reset all if swipe in other cell
        .onChange(of: mySwipeActive) { newValue in
            print("changed", newValue)
            if newValue == false && !isDragging {
                withAnimation {
                    dragX = 0
                    isActive = false
                    isDeleting = false
                    iconOffset = 40
                }
            }
        }
    }
}
