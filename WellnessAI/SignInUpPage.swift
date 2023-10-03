//
//  SignInUpPage.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI

struct SignInUpPage: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignUpActive = false
    @State private var hasSignedIn = false
    @State private var isFirst = true
    @StateObject private var lvm = LoginVM()
    @StateObject var env = DashboardEnvironment()
    var body: some View {
        NavigationStack(path: $env.path) {
            OverLay(isLoading: lvm.state == .submitting){
                VStack {
                    
                    HStack(spacing: 0){
                        Text("Sign-In")
                            .font(.title3.bold())
                            .foregroundColor(isFirst ?.white:.black)
                            .padding(.horizontal,10)
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .background(Color(isFirst ? "Primary": "white"))
                            .cornerRadius(10)
                            .onTapGesture {
                                isFirst = true
                            }
                        Text("Sign-Up")
                            .font(.title3.bold())
                            .foregroundColor(!isFirst ?.white:.black)
                            .padding(.horizontal,21)
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .background(Color(!isFirst ? "Primary": "white"))
                            .cornerRadius(10)
                            .onTapGesture {
                                isFirst = false
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("Primary"), lineWidth: 1)
                    )
                    if isFirst{
                        TopSignInLabel()
                            .padding(.bottom, 20)
                            .padding(.top,18)
                    } else{
                        TopSignUpLabel()
                            .padding(.bottom, 20)
                            .padding(.top,18)
                    }
                   
                    if isFirst {
                        CustomTextField(field: $lvm.person.email, entryName: "Username:", placeHolder: "UserName", isSecure: false)
                            .padding(.bottom, 10)
                        CustomTextField(field:  $lvm.person.password, entryName: "Password:", placeHolder: "********",isSecure: true)
                            .padding(.bottom, 40)
                    } else {
                        CustomTextField(field: $lvm.person.email, entryName: "Name:", placeHolder: "Name", isSecure: false)
                            .padding(.bottom, 10)
                        CustomTextField(field: $lvm.person.email, entryName: "Email:", placeHolder: "Email", isSecure: false)
                            .padding(.bottom, 10)
                        CustomTextField(field:  $lvm.person.password, entryName: "Password:", placeHolder: "********",isSecure: true)
                            .padding(.bottom, 10)
                        CustomTextField(field:  $lvm.person.password, entryName: "Confirm Password:", placeHolder: "********",isSecure: true)
                            .padding(.bottom, 40)
                    }
                    
                   
                    Button {
                        Task {
                            isFirst ?
                            await lvm.loginUser():await lvm.loginUser()
                            if lvm.state == .successful{
                                env.path.append(.chat)
                            }
                        }
//                        env.path.append(.chat)
                    } label: {
                        PrimaryButton(text: isFirst ? "Sign In":"Sign Up")
                    }
                    Spacer()
                    
                    HStack {
                        Text(isFirst ? "Don't have an account?":"Already have an account?")
                        Button(
                            action: {
                                switch isFirst{
                                case true:
                                    isFirst = false
                                case false:
                                    isFirst = true
                                }
                        }) {
                            Text(isFirst ?"Create one now":"Go to login")
                                .foregroundColor(Color("Primary"))
                                .fontWeight(.bold)
                        }
                    }
                    Spacer()
                }
                .padding()
                .modifier(HideKeyboardOnTap())
            }
            .alert(isPresented: $lvm.hasError, error: lvm.error) {
                
        }
            .navigationDestination(for: DashboardPath.self) { $0
                    .environmentObject(env)
            }
            
        }
    }
}


struct TopSignInLabel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hi there,")
                .font(.system(size: 16))
                .fontWeight(.bold)
            
            Text("Welcome back!")
                .font(.system(size: 28))
                .fontWeight(.medium)
                .foregroundColor(Color("Primary"))
            
            Text("Please input your log-in details.")
                .font(.title2)
                .fontWeight(.light)
                .font(.system(size: 19))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TopSignUpLabel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hi there,")
                .font(.system(size: 16))
                .fontWeight(.bold)
            
            Text("Welcome to Wellness AI!")
                .font(.system(size: 28))
                .fontWeight(.medium)
                .foregroundColor(Color("Primary"))
            
            Text("Please register to use the app.")
                .font(.title2)
                .fontWeight(.light)
                .font(.system(size: 19))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SignInUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInUpPage()
    }
}

struct HideKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        self.modifier(HideKeyboardOnTap())
    }
}
