//
//  String+Extensions.swift
//  ChatGPT9
//
//  Created by Petar Glisovic on 10/2/24.
//

import Foundation

extension String {

    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
