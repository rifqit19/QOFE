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
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack{
            
            Text(showingSignup ? "Sign Up" : "Sign In")
                .fontWeight(.heavy )
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    Text("Email")
                        .fontWeight(.light )
                        .font(.headline)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    TextField("Enter your email...", text: $email)
                    Divider()
                    
                    
                    Text("Password")
                        .fontWeight(.light )
                        .font(.headline)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter your password...", text: $password)
                    
                    Divider()
                    
                    
                    if showingSignup{
                        
                        Text("Repeat Password")
                            .fontWeight(.light )
                            .font(.headline)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                        
                        SecureField("Repeat password...", text: $repeatPassword)
                        Divider()
                        
                    }
                    
                }//end of vstack
                .padding(.bottom, 15)
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        self.resetPassword()
                    },label:{
                        Text("Forgot Password?")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    })
                    
                }// end of hstack
                
            }// end of vstack
            .padding(.horizontal, 6)
            
            Button(action: {
                self.showingSignup ? self.signUpUser() : self.loginUser()
            }, label: {
                Text(showingSignup ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            })//end of button
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.top, 50)
            
            
            SignUpView(showingSignup: $showingSignup)
        }// end of vstack
        .sheet(isPresented: $showingFinishReg) {
            FinishRegistrationView()
        }
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
            Spacer()
            
            HStack{
                Text(showingSignup ? "Already have an account?" :  "Don't have an Account??")
                    .foregroundColor(.gray)
                    .opacity(0.5)
                
                Button(action: {
                    showingSignup.toggle()
                },label:{
                    Text(showingSignup ? "Sign In" : "Sign Up")
                        .foregroundColor(.blue)
                })
                
            }
        }
    }
}
