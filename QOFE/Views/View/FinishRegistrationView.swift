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
    
    
    var body: some View {
        
        Form{
            
            Section{
                Text("Finish Registration")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 20)
                
                TextField("Name", text: $name)
                TextField("Surname", text: $surname)
                TextField("Telephone", text: $telephone)
                TextField("Address", text: $address)
            }
            
            Section{
                Button(
                    action: {
                        self.finishRegistration()
                        
                }, label: {
                    Text("Finish Registration")
                })
            }.disabled(self.fieldCompleted())
            
        }// end of form
    }
    
    private func fieldCompleted() -> Bool {
        return self.name != "" && self.surname != "" && self.telephone != "" && self.address != ""
    }
    
    private func finishRegistration(){
        
    }
}

struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}