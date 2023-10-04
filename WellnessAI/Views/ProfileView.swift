//
//  ProfileView.swift
//  WellnessAI
//
//  Created by David OH on 02/10/2023.
//

import SwiftUI

struct ProfileView: View {
    @State var isAlert: Bool = false
    @EnvironmentObject var env: DashboardEnvironment
    @EnvironmentObject private var lvm : LoginVM
    var body: some View {
        VStack(spacing: 15) {
            Image("okAvatar")
                .resizable().scaledToFit()
                .frame(width: 100, height: 100)
            if let name = lvm.userInfo?.data.name{
                Text(name)
                    .font(.title.bold())
            }
            if let email = lvm.userInfo?.data.email{
                Text(email)
                    .tint(.black)
                    .font(.body)
            }
            Divider()
            VStack(spacing: 30) {
                Button{
                    self.isAlert.toggle()
                } label: {
                    ProfileList(img: "pperson")
                }.buttonStyle(.plain)
                Button{
                    self.isAlert.toggle()
                } label: {
                    ProfileList(img: "ppadlock",text: "Change Password")
                }.buttonStyle(.plain)
                Button{
                    env.path.removeLast()
                    env.path.append(.payment)
                } label: {
                    ProfileList(img: "pwallet",text: "Suscribe to Premium")
                }.buttonStyle(.plain)
                Button{
                    self.isAlert.toggle()
                } label: {
                    ProfileList(img: "pmoon",text: "Dark Theme")
                }.buttonStyle(.plain)
                Button{
                    env.path = []
                } label: {
                    LogoutList()
                }.buttonStyle(.plain)
                
                
            }
            .padding(.vertical,30)
        }.padding()
            .navigationTitle("Profile")
            .alert("This Feature hasn't yet been implemented",isPresented: $isAlert){
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(LoginVM())
            .environmentObject(DashboardEnvironment())
    }
}
