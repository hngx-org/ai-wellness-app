//
//  PrimaryButton.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI


struct PrimaryButton: View {
    var text: String
    var background: Color = Color("Primary")
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(background)
            .cornerRadius(8)
            .shadow(radius: 10)
    }
}
#Preview {
    PrimaryButton(text:"Next")
}
