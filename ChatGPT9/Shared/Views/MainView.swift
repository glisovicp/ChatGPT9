//
//  MainView.swift
//  ChatGPT9
//
//  Created by Petar Glisovic on 10/2/24.
//

import SwiftUI
import OpenAISwift

struct MainView: View {

    @State private var chatText: String = ""

    let openAI = OpenAISwift(config: .makeDefaultOpenAI(apiKey: "OPENAI_API_KEY"))

    @EnvironmentObject private var model: Model

    @State private var isSearching: Bool = false

    private var isFormValid: Bool {
        !chatText.isEmptyOrWhitespace
    }

    var body: some View {
        VStack{

            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(model.queries, id: \.self) { query in
                        VStack(alignment: .leading) {
                            Text(query.question)
                                .fontWeight(.bold)
                            Text(query.answer)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.bottom], 10)
                            .id(query.id)
                            .listRowSeparator(.hidden)
                    }.listStyle(.plain)
                        .onChange(of: model.queries) { oldQuery, newQuery in
                            if !model.queries.isEmpty {
                                let lastQuery = model.queries[model.queries.endIndex - 1]
                                withAnimation {
                                    proxy.scrollTo(lastQuery.id)
                                }
                            }
                        }
                }
            }.padding()

            Spacer()
            HStack {
                TextField("Search...", text: $chatText)
                    .textFieldStyle(.roundedBorder)
                Button{
                    //action
                    isSearching = true
                    performSearch()
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.title)
                        .rotationEffect(Angle(degrees: 45))
                }.buttonStyle(.borderless)
                    .tint(.blue)
                .disabled(!isFormValid)

            }
        }.padding()
            .onChange(of: model.query) { oldQuery, newQuery in
                print("[ChatGPT9] [MainView] [\(#function)] >>> New query: \(newQuery)")
                model.queries.append(newQuery)
            }
            .overlay(alignment: .center) {
                if isSearching {
                    ProgressView("Searching...")
                }
            }
    }

    // MARK: - Functions

    private func performSearch() {
        openAI.sendCompletion(with: chatText,
                              maxTokens: 500) { result in
            switch result {
            case .success(let success):
                print("[ChatGPT9] [MainView] [\(#function)] >>> Success!")
                // OpenAI<TextResult>(object: nil, model: nil, choices: nil, usage: nil, data: nil)
                let answer = success.choices?.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

                let query = Query(question: chatText, answer: answer)
                // Because queries are @Published in Model, we need to update them on the main thread.
                DispatchQueue.main.async {
                    model.queries.append(query)
                }

                do {
                    try model.saveQuery(query)
                } catch {
                    print(error.localizedDescription)
                }

                chatText = ""
                isSearching = false

            case .failure(let failure):
                isSearching = false
                print("[ChatGPT9] [MainView] [\(#function)] >>> Failure:\(failure)")
            }
        }
    }

}

#Preview {
    MainView()
        .environmentObject(Model())
}
