//
//  ForgotPasswordView.swift
//  QOFE
//
//  Created by rifqi triginandri on 21/04/23.
//

import SwiftUI
import ToastSwiftUI

struct ForgotPasswordView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    
    @State var showingSignup = false
    @State var showingFinishReg = false
    
    @State private var isPresentingToastSuccess = false
    @State private var isPresentingToastError = false
    @State private var messageToast = ""
    
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
                    
                    HStack{
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.backward.circle.fill")
                                 .frame(width: 24,height: 24)
                                 .foregroundColor(.white)
                        }
                        Spacer()
                    }.padding([.trailing,.leading], 20)
                        .padding([.top], 10)
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
                    
                    Text("Reset Password")
                        .font(.title3)
                        .padding( .bottom, 45)
                        .foregroundColor(.white)

                    VStack(alignment: .leading){

                        VStack(alignment: .leading){

                            Text("Email")
                                .fontWeight(.light )
                                .font(.caption)
                                .foregroundColor(.white)
                                .opacity(0.75)

                            TextField("Enter your email...", text: $email)
                                .foregroundColor(.white)
                                .font(.caption)
                            Divider().overlay(Color.white)

                        }//end of vstack
                        .padding(.bottom, 14)

        

                    }// end of vstack
                    .padding(.horizontal, 6)

                    Button(action: {
                        self.resetPassword()
                    }, label: {
                        Text("Kirim Email")
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
            }
            
            
            
        }// end of zstask
        .background(Color.white)
        .toast(isPresenting: $isPresentingToastSuccess, message: messageToast, icon: .success, textColor: Color("darkBrown"))
        .toast(isPresenting: $isPresentingToastError, message: messageToast, icon: .error, textColor: Color("darkBrown"))
    }
    
    private func resetPassword (){
        
        if email != "" {
            FUser.resetPassword(email: email) { error in
                if error != nil {
                    print("error sending reset password ", error?.localizedDescription)
                    messageToast = error!.localizedDescription
                    isPresentingToastError.toggle()
                    return
                }
                print("please check your email")
                messageToast = "cek email anda"
                isPresentingToastSuccess.toggle()
            }

        }else{
            print("email is empty")
            messageToast = "email kosong"
            isPresentingToastError.toggle()
        }
    }

}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}


