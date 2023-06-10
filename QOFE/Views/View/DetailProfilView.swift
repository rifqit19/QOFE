//
//  DetailProfilView.swift
//  QOFE
//
//  Created by rifqi triginandri on 10/06/23.
//

import SwiftUI

struct DetailProfilView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {

        ZStack{
            GeometryReader { reader in
                Color("darkBrown")
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }

            VStack(){
                HStack(){
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .frame(width: 35,height: 24)
                            .foregroundColor(.white)
                            .scaledToFill()
                    }
                    
                    Text("Profil")
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding([.trailing,.leading], 20)
                .padding([.top, .bottom], 10)
                .background(Color("darkBrown"))
//                .edgesIgnoringSafeArea(.top )

                
                
                Spacer()
                
                HStack{
                    Spacer()
                    Image("ic_qofe_dark").ignoresSafeArea()
                }
                
            }//end of vstack
            .edgesIgnoringSafeArea(.bottom)
            
            ZStack(alignment: .top){
                
                
                
                VStack{
                    

                    Text("")
                        .font(.title3)
                        .padding( .bottom, 20)
                        .foregroundColor(.white)

                    VStack(alignment: .leading){

                        VStack(alignment: .leading){

                            VStack(alignment: .leading){
                                Text("Nama")
                                    .fontWeight(.light )
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .opacity(0.75)

                                Text(FUser.currentUser()?.fullName ?? "-")
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Divider().overlay(Color.white)


                                Text("Nomor Hp")
                                    .fontWeight(.light )
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                    .opacity(0.75)
                            }

                            Text(FUser.currentUser()?.phoneNumber ?? "-")
                                .foregroundColor(.white)
                                .font(.caption)
                            Divider().overlay(Color.white)
                            
                            Text("Email")
                                .fontWeight(.light )
                                .font(.caption)
                                .foregroundColor(.white)
                                .opacity(0.75)

                            Text(FUser.currentUser()?.email ?? "-")
                                .foregroundColor(.white)
                                .font(.caption)
                            Divider().overlay(Color.white)


                            Text("Alamat")
                                .fontWeight(.light )
                                .font(.caption)
                                .foregroundColor(.white)
                                .opacity(0.75)

                            Text(FUser.currentUser()?.fullAddress ?? "-")
                                .foregroundColor(.white)
                                .font(.caption)
                            Divider().overlay(Color.white)





                        }//end of vstack
                        .padding(.bottom, 14)

                    }// end of vstack
                    .padding(.horizontal, 6)

                    Button(action: {
                        //logout func
                        FUser.logoutCurrentUser { error in
                            print(error)
                        }
                        presentationMode.wrappedValue.dismiss()

                    }, label: {
                        Text("Logout")
                            .foregroundColor(Color("darkBrown"))
                            .frame(width: UIScreen.main.bounds.width - 170)
                            .padding()
                            .font(.subheadline)
                    })//end of button
                    .frame(height: 45)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(.top, 50)
                    

                }// end of vstack
                .frame(width: UIScreen.main.bounds.width - 120)
                .padding(30)
                .background(Color("brown"))
                .cornerRadius(20)
                
                
                ZStack{
                    Ellipse()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(Color("darkBrown"))
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                    
                }
                .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(.white, lineWidth: 4)
                    )

                .padding(.top, -50)

                
//                Image(systemName: "person.circle.fill")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(Color("darkBrown"))
//                    .overlay(
//                            RoundedRectangle(cornerRadius: 100)
//                                .stroke(.white, lineWidth: 4)
//                        )
//                    .frame(height: UIScreen.main.bounds.width / 4)
//                    .padding(.top, -70)

            }
            
            
            
        }// end of zstask
        .background(Color.white)
    }

    
}

struct DetailProfilView_Previews: PreviewProvider {
    static var previews: some View {
        DetailProfilView()
    }
}


