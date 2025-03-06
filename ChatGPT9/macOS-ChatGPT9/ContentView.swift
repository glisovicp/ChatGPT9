//
//  ContentView.swift
//  macOS-ChatGPT9
//
//  Created by Petar Glisovic on 10/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            HistoryView()
        } detail: {
            MainView()
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        .environmentObject(Model())
}
