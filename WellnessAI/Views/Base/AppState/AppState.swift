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
    case home
    case payment
    case profile
//    case lunchdetails
    case chat
    
    
}

extension DashboardPath: View {
    var body: some View {
        switch self {
        case .home:
            ChatView(selectedTab: .constant(0))
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
