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

    @State private var answers: [String] = []

    private var isFormValid: Bool {
        !chatText.isEmptyOrWhitespace
    }

    var body: some View {
        VStack{

            List(answers, id: \.self) { answer in
                Text(answer)
            }

            Spacer()
            HStack {
                TextField("Search...", text: $chatText)
                    .textFieldStyle(.roundedBorder)
                Button{
                    //action
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
                answers.append(answer)

            case .failure(let failure):
                print("[ChatGPT9] [MainView] [\(#function)] >>> Failure:\(failure)")
            }
        }
    }

}

#Preview {
    MainView()
}
