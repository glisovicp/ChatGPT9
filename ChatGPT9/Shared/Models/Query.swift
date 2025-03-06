//
//  Query.swift
//  ChatGPT9
//
//  Created by Petar Glisovic on 2/27/25.
//

import Foundation

struct Query: Identifiable, Hashable {

    let id = UUID()
    let question: String
    let answer: String
}
