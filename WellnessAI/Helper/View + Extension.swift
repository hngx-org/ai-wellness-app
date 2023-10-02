//
//  View + Extension.swift
//  WellnessAI
//
//  Created by Tes on 02/10/2023.
//

import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        if let keyWindowScene = UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene && ($0 as? UIWindowScene)?.activationState == .foregroundActive }) as? UIWindowScene {
            keyWindowScene.windows.forEach { window in
                window.endEditing(force)
            }
        }
    }
}
