//
//  LoginResponse.swift
//  WellnessAI
//
//  Created by Tes on 04/10/2023.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let data: DataClass
    let message: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let createdAt: String
    let credits: Int
    let email, id, name, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case credits, email, id, name
        case updatedAt = "updated_at"
    }
}

