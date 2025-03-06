//
//  Model.swift
//  ChatGPT9
//
//  Created by Petar Glisovic on 2/27/25.
//

import Foundation

class Model: ObservableObject {

    @Published var queries: [Query] = []
    @Published var query = Query(question: "", answer: "")                   // like a selected query

    func saveQuery(_ query: Query) throws {

        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        let historyItem = HistoryItem(context: viewContext)
        historyItem.question = query.question
        historyItem.answer = query.answer
        historyItem.dateCreated = Date()
        try viewContext.save()
    }

}
