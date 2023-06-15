//
//  MainViewedView.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 9/6/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MainListView()
                .tabItem {
                    Label("Anime list", systemImage: "list.bullet")
                }
            
            ListViewedAnime()
                .tabItem {
                    Label("List viewed", systemImage: "text.badge.checkmark")
                }
        }
    }
}

struct MainViewedView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AnimeVM())
            .preferredColorScheme(.dark)
    }
}
