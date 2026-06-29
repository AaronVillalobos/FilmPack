//
//  ContentView.swift
//  FilmPack
//
//  Created by Aaron Villalobos on 6/13/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let dataContainer = DataContainer()

    var body: some View {
        VStack {
            PackView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
        .padding()
        .background(Color.jet)
    }
}

#Preview {
    ContentView()
}
