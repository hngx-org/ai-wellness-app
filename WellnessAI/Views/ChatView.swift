//
//  ChatView.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI

struct ChatView: View {
    @Binding var selectedTab: Int
    @EnvironmentObject var env: DashboardEnvironment
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Spacer()
                Button{
                    env.path.append(.payment)
                }
            label: {
                Text("Suscribe To Premium")
                    .font(.body.bold())
                    .padding(.trailing,10)
            }
            }
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                Button{
                    env.path.append(.profile)
                } label: {
                    Image("pperson")
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(selectedTab: .constant(0))
            .environmentObject(DashboardEnvironment())
    }
}
