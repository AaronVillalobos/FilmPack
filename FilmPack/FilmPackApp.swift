//
//  FilmPackApp.swift
//  FilmPack
//
//  Created by Aaron Villalobos on 6/13/26.
//

import SwiftUI
import SwiftData

@main
struct FilmPackApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}

