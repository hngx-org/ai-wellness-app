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
//        Message(content: "What do you think about headaches in the forehead?", user: DataSource.secondUser),
//        Message(content: "AI: As an AI, I don't have personal thoughts or feelings. However, a headache in the forehead can be a common symptom and can be caused by various factors. Some possible causes include tension headaches, sinusitis, eyestrain, dehydration, or even stress. It's always a good idea to consult with a medical professional for a proper diagnosis and appropriate treatment if you are experiencing persistent or severe headaches.", user: DataSource.firstUser)
    ]
}
