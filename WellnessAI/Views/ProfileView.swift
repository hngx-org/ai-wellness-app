//
//  ProfileView.swift
//  WellnessAI
//
//  Created by David OH on 02/10/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var env: DashboardEnvironment
    var body: some View {
            VStack(spacing: 15) {
                Image("okAvatar")
                    .resizable().scaledToFit()
                    .frame(width: 100, height: 100)
                Text("Name")
                    .font(.title.bold())
                Text("email")
                    .tint(.black)
                    .font(.body)
                Divider()
                VStack(spacing: 30) {
                   ProfileList(img: "pperson")
                    ProfileList(img: "ppadlock",text: "Change Password")
                    Button{
                        env.path.removeLast()
                        env.path.append(.payment)
                    } label: {
                        ProfileList(img: "pwallet",text: "Suscribe to Premium")
                    }.buttonStyle(.plain)
                    ProfileList(img: "pmoon",text: "Dark Theme")
                    Button{
                        env.path = []
                    } label: {
                        LogoutList()
                    }.buttonStyle(.plain)
                    
                    
                }
                .padding(.vertical,30)
            }.padding()
            .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(DashboardEnvironment())
    }
}
