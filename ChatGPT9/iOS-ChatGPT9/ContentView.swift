//
//  ContentView.swift
//  iOS-ChatGPT9
//
//  Created by Petar Glisovic on 10/2/24.
//

import SwiftUI

struct ContentView: View {

    @State private var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            MainView()
                .sheet(isPresented: $isPresented, content: {
                    NavigationStack {
                        HistoryView()
                            .navigationTitle("History")
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isPresented = true
                        } label: {
                            Text("Show History")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        .environmentObject(Model())
}
