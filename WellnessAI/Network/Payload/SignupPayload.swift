//
//  SignupPayload.swift
//  WellnessAI
//
//  Created by Tes on 04/10/2023.
//

import Foundation

struct SignupPayload: Codable {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var confirm_password: String = ""
}
