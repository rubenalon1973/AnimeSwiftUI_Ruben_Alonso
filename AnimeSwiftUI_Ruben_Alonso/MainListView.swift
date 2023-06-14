//
//  ContentView.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 11/4/23.
//

import SwiftUI

struct MainListView: View {

    @EnvironmentObject var vm:AnimeVM

    var body: some View {

        NavigationStack {
            List(vm.filteredAnimes) { anime in
                NavigationLink(value: anime) {
                    AnimeCell(anime: anime)
                }
            }
            .navigationDestination(for: MyAnimeModel.self, destination: { anime in
                DetailView(anime: anime)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Menu("Sorted By Type") {
                            Picker(selection: $vm.animeTypes) {
                                ForEach(AnimeType.allCases) { animeType in
                                    Text(animeType.rawValue)
                                }
                            } label: {
                                Text("Sorted By Type")
                            }
                        }
                        Menu("Order By") {
                            Picker(selection: $vm.sortedBy) {
                                ForEach(SortedBy.allCases) { animeStatus in
                                    Text(animeStatus.rawValue)
                                }
                            } label: {
                                Text("Oder By")
                            }
                        }
                    } label: {
                        Label("Filter", systemImage:  "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .navigationTitle("Animes")
            .listStyle(.insetGrouped)
            .searchable(text: $vm.search, placement: .navigationBarDrawer(displayMode: .always), prompt: "search")
        }
        .animation(.default, value: vm.search)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .environmentObject(AnimeVM.preview)
            .preferredColorScheme(.dark)

    }
}

struct AnimeCell: View {
    let anime: MyAnimeModel
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: anime.image)) { image in
                image
                    .resizable()
                    .frame(width: 105, height: 105)
                    .cornerRadius(10)
                    .shadow(color: .white.opacity(70.0), radius: 10.0, x: 3, y: -3)
                HStack {
                    if anime.isViewed {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                        Text("Viewed")
                            .bold()
                    } else {
                        Image(systemName: "xmark.seal")
                            .foregroundColor(.red)
                        Text("Unviewed")
                            .bold()
                    }
                }
            } placeholder: {
                Image(systemName: "popcorn")
                    .resizable()
                    .frame(width: 105, height: 105)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(anime.title)
                    .bold()
                Text("Episodes: \(anime.episodes)")
                    .foregroundColor( .secondary.opacity(10.00))
                Text(anime.type.rawValue)
                    .foregroundColor( .secondary.opacity(10.00))
            }
            .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
    }
}




