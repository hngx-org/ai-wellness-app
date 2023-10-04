//
//  ResponsePayload.swift
//  WellnessAI
//
//  Created by Tes on 04/10/2023.
//

import Foundation

struct ResponsePayload: Codable {
    var userInput: String = ""
    var history : [String] = []
}

struct SendMessagePayload: Codable {
    var user_input: String = ""
}
