//
//  LoginView.swift
//  QOFE
//
//  Created by rifqitriginandri on 06/03/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    
    @State var showingSignup = false
    @State var showingFinishReg = false
    @State var showingResetPass = false

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
                    
                    Text(showingSignup ? "Sign Up" : "Sign In")
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


                            Text("Password")
                                .fontWeight(.light )
                                .font(.caption)
                                .foregroundColor(Color.white)
                                .opacity(0.75)

                            SecureField("Enter your password...", text: $password)
                                .foregroundColor(.white)
                                .font(.caption)
                            Divider().overlay(Color.white)


                            if showingSignup{

                                Text("Repeat Password")
                                    .fontWeight(.light )
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                    .opacity(0.75)

                                SecureField("Repeat password...", text: $repeatPassword)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Divider().overlay(Color.white)

                            }

                        }//end of vstack
                        .padding(.bottom, 14)

                        HStack{
                            Spacer()

                            Button("Forgot Password?"){
                                showingResetPass.toggle()
                                
                            }.foregroundColor(.white)
                                .font(.caption)
                            .fullScreenCover(isPresented: $showingResetPass) {
                                ForgotPasswordView()
                            }
                            
                            Spacer()

                        }// end of hstack

                    }// end of vstack
                    .padding(.horizontal, 6)

                    Button(action: {
                        self.showingSignup ? self.signUpUser() : self.loginUser()
                    }, label: {
                        Text(showingSignup ? "Sign Up" : "Sign In")
                            .foregroundColor(Color("darkBrown"))
                            .frame(width: UIScreen.main.bounds.width - 170)
                            .padding()
                            .font(.subheadline)
                    })//end of button
                    .frame(height: 45)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(.top, 50)

                    SignUpView(showingSignup: $showingSignup)
                        .padding(.top, 8)
                }// end of vstack
                .sheet(isPresented: $showingFinishReg) {
                    FinishRegistrationView()
    //            }


                    
                }
                .frame(width: UIScreen.main.bounds.width - 120)
                .padding(30)
                .background(Color("brown"))
                .cornerRadius(20)
            }
            
            
            
        }// end of zstask
    }
    
    private func loginUser(){
        if email != "" && password != "" {
            FUser.loginUserWith(email: email, password: password) { error, isEmailVerified in
                if error != nil{
                    print("error loging in the user: ", error!.localizedDescription)
                    return
                }
                
//                print("user login successful, email is verified: ", isEmailVerified)
                if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding{
                    self.presentationMode.wrappedValue.dismiss()
                }else{
                    self.showingFinishReg.toggle()
                }
                
            }
        }
    }
    
    private func signUpUser(){
        if email != "" && password != "" && repeatPassword != ""{
            if password == repeatPassword{
                
                FUser.registerUserWith(email: email, password: password) { error in
                    if error != nil{
                        print("Error registering user: ", error!.localizedDescription)
                        return
                    }
                    print("user has been created")
                    // go back to the app
                    //check ig user onboarding is done
                }

            }else{
                print("password dont match")
            }
        }else{
            print("Email and password must be set")
        }
    }
    
    private func resetPassword (){
        
        if email != "" {
            FUser.resetPassword(email: email) { error in
                if error != nil {
                    print("error sending reset password ", error?.localizedDescription)
                    return
                }
                print("please check your email")
            }

        }else{
            print("email is empty")
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SignUpView: View{
    
    @Binding var showingSignup: Bool
    
    var body: some View{
        
        VStack{
//            Spacer()
            
            HStack{
                Text(showingSignup ? "Already have an account?" :  "Don't have an Account?")
                    .foregroundColor(.white)
                    .opacity(0.5)
                    .font(.caption)
                
                Button(action: {
                    showingSignup.toggle()
                },label:{
                    Text(showingSignup ? "Sign In" : "Sign Up")
                        .foregroundColor(.white)
                        .font(.caption)
                })
                
            }
        }
    }
}
