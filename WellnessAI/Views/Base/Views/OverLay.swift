//
//  OverLay.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI

struct OverLay<Content>: View where Content:  View {
    var isLoading: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack {
            content()
                .disabled(isLoading)
                .blur(radius: isLoading ? 2 : 0)
            
            if isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .scaleEffect(1.5)
            }
        }
    }
}


struct OverLay_Previews: PreviewProvider {
    static var previews: some View {
        OverLay(isLoading: true) {
            Text("")
        }
    }
}
