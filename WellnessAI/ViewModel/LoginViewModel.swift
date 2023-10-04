//
//  LoginViewModel.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import SwiftUI
import Foundation

class LoginVM: BaseViewModel, ObservableObject{
//    @Published var person = LoginPayload(email: "testing07@mail.com", password: "password")
    @Published var person = LoginPayload() // to use in production
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
             let response = try await NetworkingManager.shared.request(endpoint: .signIn(loginData: data), type: LoginResponse.self)
//             self.userInfo = response.data
//             self.loginStatusCode = response.statusCode
             print("Succesful \(String(describing: response.message))")
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
    
    func loginNewUser(email: String, password: String) async {
        let person = LoginPayload(email: email, password: password)
        do{
            state = .submitting
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .useDefaultKeys
            let data = try? encoder.encode(person)
            let response = try await NetworkingManager.shared.request(endpoint: .signIn(loginData: data), type: LoginResponse.self)
//             self.userInfo = response.data
//             self.loginStatusCode = response.statusCode
            print("Succesful \(String(describing: response.message))")
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
