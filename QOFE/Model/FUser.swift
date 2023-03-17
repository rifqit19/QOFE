//
//  FUser.swift
//  QOFE
//
//  Created by rifqitriginandri on 16/03/23.
//

import Foundation
import FirebaseAuth

class FUser{
    
    let id: String
    var email: String
    var firstName: String
    var lastName: String
    var fullName: String
    var phoneNumber: String
    
    var fullAddress: String?
    var onBoarding: Bool
    
    init(id: String, email: String, firstName: String, lastName: String, phoneNumber: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = firstName + " " + lastName
        self.phoneNumber = phoneNumber
        onBoarding = false
    }
    
    class func currentId() -> String{
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser() -> FUser?{
        
        if Auth.auth().currentUser != nil{
            if let dictionary = userDefault.object(forKey: kCURRENTUSER){
                return nil
            }
        }
        
        return nil
    }
    
    class func loginUserWith(email: String, password: String, completion: @escaping(_ error: Error?, _ isEmailVerified: Bool)-> Void){
        
        Auth.auth().signIn(withEmail: email, password: password){ authDataResult,error in
            if error == nil {
                if authDataResult!.user.isEmailVerified{
                    //download FUser Object and save it locally
                }else{
                    completion(error, false)
                }
            }else{
                completion(error, false)
            }
        }
    }
    
    class func registerUserWith(email: String, password: String, completion: @escaping(_ error: Error?)-> Void){
        
        Auth.auth().createUser(withEmail: email, password: password){ authDataResult,error in
            
            completion(error)
            
            if error == nil {
                authDataResult!.user.sendEmailVerification { error in
                    print("verification email sent error is: ", error?.localizedDescription)
                }
            }
        }
    }
    
    
}
