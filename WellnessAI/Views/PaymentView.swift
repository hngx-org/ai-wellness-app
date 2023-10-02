//
//  PaymentView.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI

struct PaymentView: View {
    private var pay: Int = 10
    var body: some View {
        VStack(spacing:30) {
            Spacer()
            Text("You have to pay to $\(pay) access all the AI features and explore it's capability even more")
                .font(.headline.weight(.bold))
                .foregroundColor(.mint)
            PrimaryButton(text: "Pay")
            Spacer()
        }.padding(.horizontal,10)
    }
}

#Preview {
    PaymentView()
}
