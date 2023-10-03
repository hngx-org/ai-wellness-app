//
//  Message.swift
//  WellnessAI
//
//  Created by Tes on 02/10/2023.
//

import Foundation

struct Message: Hashable {
    var content: String
    var user: User
}

struct DataSource {
    static let firstUser = User(name: "Wellness AI", avatar: "openai_logo")
    static var secondUser = User(name: "Duy Bui", avatar: "myAvatar", isCurrentUser: true)
    static let messages = [
        Message(content: "Hi, how may I help you today?", user: DataSource.firstUser),
    ]
}
