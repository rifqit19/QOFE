//
//  FInishRegistrationView.swift
//  QOFE
//
//  Created by rifqitriginandri on 07/03/23.
//

import SwiftUI

struct FinishRegistrationView: View {
    
    @State var name = ""
    @State var surname = ""
    @State var telephone = ""
    @State var address = ""
    
    @State var showingHome = false

    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View {
        
        ZStack{
            VStack(){
                ZStack(alignment: .top){
                    Image("elips_login")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .background(
                        Image("elips_login").resizable()
                    ).ignoresSafeArea()
                    
//                    HStack{
//                        Button {
//                            presentationMode.wrappedValue.dismiss()
//                        } label: {
//                            Image(systemName: "arrow.backward.circle.fill")
//                                 .frame(width: 24,height: 24)
//                                 .foregroundColor(.white)
//                        }
//                        Spacer()
//                    }.padding([.trailing,.leading], 20)
                }
                
                
                Spacer()
                
                HStack{
                    Spacer()
                    Image("ic_qofe_dark").ignoresSafeArea()
                }
                
            }//end of vstack
            .edgesIgnoringSafeArea(.bottom)
            
            VStack{
                
                Image("qofe_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: UIScreen.main.bounds.width / 8)
                    .padding(.bottom, UIScreen.main.bounds.height / 20)
                
                VStack{
                    
                    Text("Finish Register")
                        .font(.title3)
                        .padding( .bottom, 45)
                        .foregroundColor(.white)

                    VStack(alignment: .leading){

                        VStack(alignment: .leading){

                            VStack(alignment: .leading){
                                Text("Firstname")
                                    .fontWeight(.light )
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .opacity(0.75)

                                TextField("Enter your firstname...", text: $name)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Divider().overlay(Color.white)
                            }


                            VStack(alignment: .leading){
                                Text("Lastname")
                                    .fontWeight(.light )
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                    .opacity(0.75)

                                TextField("Enter your lastname...", text: $surname)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Divider().overlay(Color.white)
                            }
                            
                            VStack(alignment: .leading){
                                Text("Phone Number")
                                    .fontWeight(.light )
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                    .opacity(0.75)
                                
                                TextField("Enter your phone number...", text: $telephone)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Divider().overlay(Color.white)
                            }
                            
                            VStack(alignment: .leading){
                                Text("Address")
                                    .fontWeight(.light )
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                    .opacity(0.75)
                                
                                TextField("Enter your address...", text: $address)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Divider().overlay(Color.white)
                            }
                            

                        }//end of vstack
                        .padding(.bottom, 14)

                        

                    }// end of vstack
                    .padding(.horizontal, 6)

                    Button(action: {
                       
                        self.finishRegistration()
                        
                    }, label: {
                        Text("Finish")
                            .foregroundColor(Color("darkBrown"))
                            .frame(width: UIScreen.main.bounds.width - 170)
                            .padding()
                            .font(.subheadline)
                    })//end of button
                    .frame(height: 45)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(.top, 50)
                    .disabled(!self.fieldCompleted())

                    
                }// end of vstack
                .sheet(isPresented: $showingHome) {
                    HomeView()
                }
                .frame(width: UIScreen.main.bounds.width - 120)
                .padding(30)
                .background(Color("brown"))
                .cornerRadius(20)
            }
            
            
            
        }// end of zstask
        
//        Form{
//
//            Section{
//                Text("Finish Registration")
//                    .fontWeight(.heavy)
//                    .font(.largeTitle)
//                    .padding([.top, .bottom], 20)
//
//                TextField("Name", text: $name)
//                TextField("Surname", text: $surname)
//                TextField("Telephone", text: $telephone)
//                TextField("Address", text: $address)
//            }
//
//            Section{
//                Button(
//                    action: {
//                        self.finishRegistration()
//
//                }, label: {
//                    Text("Finish Registration")
//                })
//            }.disabled(!self.fieldCompleted())
//
//        }// end of form
    }
    
    private func fieldCompleted() -> Bool {
        return self.name != "" && self.surname != "" && self.telephone != "" && self.address != ""
    }
    
    private func finishRegistration(){
        
        let fullName = name + " " + surname
        
        updateCurrentUser(withValues: [kFIRSTNAME : name, kLASTNAME : surname, kFULLNAME : fullName, kFULLADDRESS : address, kPHONENUMBER : telephone, kONBOARD : true]) { error in
            
            if error != nil{
                print("error updating user: ", error!.localizedDescription)
                return
            }
            
            downloadUserFromFirestore(userId: FUser.currentId(), email: FUser.currentUser()?.email ?? " ") { error in

                
            }
            
            self.presentationMode.wrappedValue.dismiss()
        }
        
    }
}

struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}
