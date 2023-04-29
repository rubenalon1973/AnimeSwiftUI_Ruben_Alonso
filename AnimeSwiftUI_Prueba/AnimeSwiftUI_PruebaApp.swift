//
//  AnimeSwiftUI_PruebaApp.swift
//  AnimeSwiftUI_Prueba
//
//  Created by Ruben Alonso on 11/4/23.
//

import SwiftUI
//Este fichero es el más imp., es el q arranca la app y mostrará la 1ª vista(ContentView)
@main
struct AnimeSwiftUI_PruebaApp: App {
    @StateObject var vm = AnimeVM()//este @State arranca el cerebro AnimeVM(), al ser observador, sabrá cuando cambia la var en AnimeVm, al estar @published la var
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
