//
//  CustomTextField.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI


struct CustomTextField: View {
    @Binding var field: String
    var entryName: String
    var placeHolder: String
    var isSecure: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(entryName)
            HStack {
                if isSecure {
                    SecureField(placeHolder, text: $field)
                        .textFieldStyle(PlainTextFieldStyle())
                        .autocapitalization(.none)
                } else {
                    TextField(placeHolder, text: $field)
                        .autocapitalization(.none)
                }
            }
            .frame(height: 50)
            .cornerRadius(25)
            .padding(.horizontal, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 0.3)
            )
        }
    }
}


struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(field: .constant(""), entryName: "Username", placeHolder: "Your username", isSecure: false)
    }
}
