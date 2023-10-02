//
//  User.swift
//  WellnessAI
//
//  Created by Tes on 02/10/2023.
//

import Foundation

struct User: Hashable {
    var name: String
    var avatar: String
    var isCurrentUser: Bool = false
}
