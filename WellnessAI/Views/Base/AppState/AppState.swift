//
//  AppState.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI

//For Navigation
class DashboardEnvironment: ObservableObject {
    @Published var path: [DashboardPath] = []
}

enum DashboardPath: Hashable, Equatable {
    case payment
    case profile
//    case lunchdetails
    case chat
    
    
}

extension DashboardPath: View {
    var body: some View {
        switch self {
        case .payment:
            PaymentView()
        case .profile:
            ProfileView()
        case .chat:
            TheChatView()
                .environmentObject(ChatHelper())
        }
    }
}
