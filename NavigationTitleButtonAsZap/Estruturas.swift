//
//  ContentView.swift
//  NavigationTitleButtonAsZap
//
//  Created by Juliano on 08/10/24.
//

import SwiftUI

struct Conversation: Equatable {
    let username: String
    let lastMessage: String
}

let conversations = [
    Conversation(
        username: "Alice",
        lastMessage: "Aloo, como vai por ai? Vamos tomar uma! Tem tempo que não saimos"
    ),
    Conversation(
        username: "Luiz",
        lastMessage: "Estou sentindo sua falta, você melhorou da doença?"
    ),
    Conversation(
        username: "Luan",
        lastMessage: "Pessoal, o basquete está confirmado hoje mesmo? Queria saber se vou ter que levar minha bola, senão vou sem mesmo"
    )
]

struct ConversationDetailView: View {
    
    let conversation: Conversation
    @Environment(\.presentationMode) private var presentationMode //controla botao de voltar
    
    var body: some View {
        VStack {
            Text("Detalhes da Conversa")
                .font(.largeTitle)
                .padding()
            
            Text("Conversa com \(conversation.username)")
                .font(.title2)
                .padding()
            
            Text("\(conversation.lastMessage)")
                .font(.title2)
                .padding()
            
            Spacer()
            
        }
        .navigationTitle(conversation.username)
        .navigationBarBackButtonHidden()
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Voltar") {
                    presentationMode.wrappedValue.dismiss()
                }
            } //toolbarItem
            
        } //toolbar
        
    } //body
}

struct AllConversationsView: View {
    
    @Environment(\.presentationMode) private var presentationMode //controla botao de voltar
    
    var body: some View {
        VStack {
            Text("Essa é a tela de detalhes geral da conversas! haha")
                .font(.largeTitle)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Conversas")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Voltar") {
                    presentationMode.wrappedValue.dismiss()
                }
            } // ToolbarItem
        } //toolbar
    } // body
}


struct ContentView: View {
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                Section(header: ButtonsHeaderView()) {
                    
                    ForEach(conversations.indices, id: \.self) { index in
                        
                        NavigationLink(destination: ConversationDetailView(conversation: conversations[index])
                        ) {
                            makeCellItem(of: conversations[index], from: index)
                        }
                        
                    } // forEach
                    .padding(.vertical, 1)
                    
                } // section
                .padding(.horizontal, 20)
                
                Spacer() //sobe secao
                
            } // scrollView
            .navigationBarTitleDisplayMode(.inline)
            
        }// navigationsStack
        
    } //body
    
    
    private func makeCellItem(of conversation: Conversation, from index: Int) -> some View {
        return VStack {
            HStack {
                VStack (alignment: .leading) {
                    Text(conversation.username)
                        .font(.headline)
                    Text(conversation.lastMessage)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }
            .padding(.vertical, 5)
            
            if conversations[index] != conversations.last {
                Divider()
            }
        }
    }
}

struct ButtonsHeaderView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            EmptyView()
                .frame(width: 0, height: 0)
            //sebosidade
        }
        .toolbar {
            
            ToolbarItem(placement: .primaryAction) {
                Button(
                    action: {
                        showAlert = true
                    }, label:
                        {
                            Image(systemName: "plus")
                        }
                ).alert(isPresented: $showAlert) { //alerta do botao
                    
                    Alert(
                        title: Text("Cria nova conversação"),
                        message: Text("Essa tela ainda esta sendo feita"),
                        dismissButton: .default(Text("OK"))
                    )
                } // alert
                
            } // ToolbarItem
            
            ToolbarItem(placement: .principal) {
                NavigationLink(destination: AllConversationsView()) {
                    Text("Conversas")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            } // ToolbarItem
            
        } // toolbar
        
    } //body
}

#Preview {
    ContentView()
}
