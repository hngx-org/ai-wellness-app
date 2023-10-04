//
//  SignupResponseModel.swift
//  WellnessAI
//
//  Created by Tes on 04/10/2023.
//

import Foundation

// MARK: - SignupResponseModel
struct SignupResponseModel: Codable {
    let data: SignupDataClass
    let message: String
}

// MARK: - SignupDataClass
struct SignupDataClass: Codable {
    let createdAt: String
    let credits: Int
    let email, id, name, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case credits, email, id, name
        case updatedAt = "updated_at"
    }
}
