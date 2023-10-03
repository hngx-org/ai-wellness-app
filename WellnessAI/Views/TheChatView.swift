//
//  TheChatView.swift
//  WellnessAI
//
//  Created by Tes on 02/10/2023.
//

import SwiftUI

struct TheChatView: View {
    @EnvironmentObject var env: DashboardEnvironment
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    @StateObject var viewModel = ChatViewModel()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        VStack {
            Button{
                env.path.append(.payment)
            }
        label: {
            HStack {
                Spacer()
                Text("Suscribe To Premium")
                    .font(.body.bold())
                .padding(.trailing,10)
            }
        }
            List {
                ForEach(chatHelper.realTimeMessages, id: \.self) { msg in
                    MessageView(currentMessage: msg)
                }
                .listRowSeparator(.hidden, edges: .bottom)
            }
            .listStyle(.plain)
            HStack {
                TextField("How can I help?...", text: $viewModel.responseMsg.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                Button {
                    if viewModel.responseMsg.userInput != "" {
                        Task {
                            sendMessage()
                            await viewModel.send(viewModel.responseMsg.userInput)
                            let messageReturned = viewModel.returnedMessage
                            print("see message returned \(messageReturned ?? "avd")")
                            sendAIMessage((messageReturned ?? viewModel.error?.errorDescription) ?? "v")
                        }
                    }
                } label: {
                    Text("Send")
                        .padding(.horizontal,14)
                        .padding(.vertical,5.5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewModel.state != .submitting ? Color("Primary"):Color(.gray), lineWidth: 1)
                        )
                }
                .disabled(viewModel.state == .submitting)
            }.frame(minHeight: CGFloat(50)).padding()
        }
        .overlay(alignment: .bottom){
            if viewModel.state == .submitting{
                VStack {
                    ProgressView()
                    Spacer()
                        .frame(maxHeight: 100)
                }
            }
        }
        .navigationBarTitle(Text(DataSource.firstUser.name), displayMode: .inline)
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
        
        .onTapGesture {
            self.endEditing(true)
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) { }
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                Button{
                    env.path.append(.profile)
                } label: {
                    Image("pperson")
                }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
    
    func sendMessage() {
        if viewModel.responseMsg.userInput != "" {
            chatHelper.sendMessage(Message(content: viewModel.responseMsg.userInput, user: DataSource.secondUser))
            viewModel.message.user_input = viewModel.responseMsg.userInput
            viewModel.responseMsg.userInput = ""
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
