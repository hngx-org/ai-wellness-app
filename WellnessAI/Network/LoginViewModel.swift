//
//  LoginViewModel.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI
import Foundation

class LoginVM: ObservableObject{
    @Published var person = LoginPayload()
    @Published private(set) var userInfo : LoginResponse?
    @Published private(set) var state : SubmissionState?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError: Bool = false
    @Published private(set) var loginStatusCode : Int?
  
    @MainActor
     func loginUser() async {
         do{
             state = .submitting
             let encoder = JSONEncoder()
             encoder.keyEncodingStrategy = .useDefaultKeys
             let data = try? encoder.encode(person)
             let response = try await NetworkingManager.shared.request(endpoint: .signIn(loginData: data), type: logins.self)
             self.userInfo = response.data
             self.loginStatusCode = response.statusCode
             print("Succesful \(String(describing: loginStatusCode))")

             if let accessToken = self.userInfo?.accessToken {
                 UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
             }
             state = .successful
         }catch{
             print("UnSuccesful")
             self.hasError = true
             if let networkingError = error as? NetworkingManager.NetworkingError{
                 self.error = networkingError
             } else{
                 self.error = .custom(error: error)
             }
             self.state = .unsuccessful
             print(self.error ?? .custom(error: error))
         }
         
     }
 }

extension LoginVM {
    enum SubmissionState{
        case unsuccessful
        case successful
        case submitting
    }
}

struct logins: Codable {
    let statusCode: Int?
    let data: LoginResponse?
}

///testing without codingKeys
struct LoginResponse: Codable, Equatable{
    let accessToken : String?
    let email : String?
    let orgId : Int?
    let isAdmin : Int?
}
struct LoginPayload: Codable {
    var email: String = ""
    var password: String = ""
}
