//
//  HistoryView.swift
//  ChatGPT9
//
//  Created by Petar Glisovic on 2/27/25.
//

import SwiftUI

struct HistoryView: View {

    @EnvironmentObject private var model: Model
    @Environment(\.dismiss) private var dismiss         // Dismiss the view

    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: true)])
    private var historyItemResults: FetchedResults<HistoryItem>

    var body: some View {
        List(historyItemResults) { historyItem in
            Text(historyItem.question ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    model.query = Query(question: historyItem.question ?? "", answer: historyItem.answer ?? "")
                    dismiss()
                }
        }
    }
}

#Preview {
    HistoryView()
        .environmentObject(Model())
}
