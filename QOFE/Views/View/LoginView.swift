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
    
    
    var body: some View {
        VStack{
            
            Text("Sign In")
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
                        print("forgot pass")
                    },label:{
                        Text("Forgot Password?")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    })
                    
                }// end of hstack
                
            }// end of vstack
            .padding(.horizontal, 6)
            
            Button(action: {
                self.showingSignup ? self.registerUser() : self.loginUser()
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
    }
    
    private func loginUser(){
        print("login")
    }
    
    private func registerUser(){
        print("registe")
    }
    
    private func resetPassword (){
        print("reset pass")
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
                Text("Don't have an Account??")
                    .foregroundColor(.gray)
                    .opacity(0.5)
                
                Button(action: {
                    showingSignup.toggle()
                },label:{
                    Text("Sign Up")
                        .foregroundColor(.blue)
                })

                
            }
        }
    }
}
