//
//  AnimeSwiftUI_Ruben_AlonsoApp.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 11/4/23.
//

import SwiftUI

@main
struct AAnimeSwiftUI_Ruben_Alonso: App {
    @StateObject var vm = AnimeVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .preferredColorScheme(.dark)
        }
    }
}
