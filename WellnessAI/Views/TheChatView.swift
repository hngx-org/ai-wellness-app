//
//  TheChatView.swift
//  WellnessAI
//
//  Created by Tes on 02/10/2023.
//

import SwiftUI

struct TheChatView: View {
    @State var typingMessage: String = ""
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    @StateObject private var viewModel = ChatViewModel()

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            OverLay(isLoading: viewModel.state == .submitting){
                VStack {
                    List {
                        ForEach(chatHelper.realTimeMessages, id: \.self) { msg in
                            MessageView(currentMessage: msg)
                        }
                        .listRowSeparator(.hidden, edges: .bottom)
                    }
                    .listStyle(.plain)
                    HStack {
                        TextField("How can I help?...", text: $typingMessage)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minHeight: CGFloat(30))
                        Button {
                            if typingMessage != "" {
                                Task {
                                    sendMessage()
                                    await viewModel.send(typingMessage)
                                    let messageReturned = viewModel.returnedMessage
                                    print("see message returned \(messageReturned ?? "avd")")
                                    sendAIMessage((messageReturned ?? viewModel.error?.errorDescription) ?? "v")
                                }
                            }
                        } label: {
                            Text("Send")
                        }
                    }.frame(minHeight: CGFloat(50)).padding()
                }.navigationBarTitle(Text(DataSource.firstUser.name), displayMode: .inline)
                    .padding(.bottom, keyboard.currentHeight)
                    .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
            }
            .onTapGesture {
                self.endEditing(true)
            }
            .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
                
            }
        }
    }
    
    func sendMessage() {
        if typingMessage != "" {
            chatHelper.sendMessage(Message(content: typingMessage, user: DataSource.secondUser))
            viewModel.message.user_input = typingMessage
            typingMessage = ""
        }
    }
    
    func sendAIMessage(_ message: String) {
        chatHelper.sendMessage(Message(content: message, user: DataSource.firstUser))
    }
}

struct TheChatView_Previews: PreviewProvider {
    static var previews: some View {
        TheChatView()
            .environmentObject(ChatHelper())
    }
}
