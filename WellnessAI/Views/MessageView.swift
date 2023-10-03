//
//  MessageView.swift
//  WellnessAI
//
//  Created by Tes on 02/10/2023.
//

import SwiftUI

struct MessageView : View {
    var currentMessage: Message
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            if !currentMessage.user.isCurrentUser {
                Image(currentMessage.user.avatar)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            } else {
                Spacer()
            }
            ContentMessageView(contentMessage: currentMessage.content,
                               isCurrentUser: currentMessage.user.isCurrentUser)
        }.padding()
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(currentMessage: Message(content: "There are a lot of premium iOS templates on iosapptemplates.com", user: DataSource.firstUser))
    }
}
