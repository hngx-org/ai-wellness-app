//
//  ChatViewModel.swift
//  WellnessAI
//
//  Created by GIGL iOS on 02/10/2023.
//

import Foundation

class ChatViewModel: BaseViewModel, ObservableObject {
    @Published var message = SendMessagePayload()
    @Published private(set) var returnedMessage : String?
    @Published private(set) var state : SubmissionState?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError: Bool = false
  
    @MainActor
    func send(_ message: String) async {
         do{
             state = .submitting
             let encoder = JSONEncoder()
             encoder.keyEncodingStrategy = .useDefaultKeys
             let data = try? encoder.encode(message)
             let response = try await NetworkingManager.shared.request(endpoint: .sendMessage(data: data), type: MessageResponse.self)
             self.returnedMessage = response.message
             print("Succesful \(String(describing: returnedMessage))")
             state = .successful
         }catch{
             print("UnSuccesful")
             self.hasError = true
             self.state = .unsuccessful
             if let networkingError = error as? NetworkingManager.NetworkingError{
                 self.error = networkingError
             } else{
                 self.error = .custom(error: error)
             }
             print(self.error ?? .custom(error: error))
         }
         
     }
 }

struct SendMessagePayload: Codable {
    var user_input: String = ""
}

struct MessageResponse: Codable {
    let message: String?
}
