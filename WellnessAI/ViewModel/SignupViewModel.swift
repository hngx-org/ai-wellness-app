//
//  SignupViewModel.swift
//  WellnessAI
//
//  Created by Tes on 04/10/2023.
//

import Foundation

class SignupViewModel: BaseViewModel, ObservableObject{
//    @Published var person = SignupPayload(name: "Bolaji", email: "testing079@mail.com", password: "password", confirm_password: "password")
    @Published var person = SignupPayload() // to use in production
    @Published private(set) var creationMessage : String?
    @Published private(set) var state : SubmissionState?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError: Bool = false
    @Published private(set) var loginStatusCode : Int?
  
    @MainActor
     func createUser() async {
         do{
             state = .submitting
             let encoder = JSONEncoder()
             encoder.keyEncodingStrategy = .useDefaultKeys
             let data = try? encoder.encode(person)
             let response = try await NetworkingManager.shared.request(endpoint: .signUp(data: data), type: SignupResponseModel.self)
             self.creationMessage = response.message
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
