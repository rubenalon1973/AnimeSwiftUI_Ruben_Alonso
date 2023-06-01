//
//  ContentView.swift
//  AnimeSwiftUI_Ruben_Alonso
//
//  Created by Ruben Alonso on 11/4/23.
//

import SwiftUI

struct ContentView: View {
    
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
                    Menu("Filter") {
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
                    }
                }
            }
            .navigationTitle("Animes")
            .listStyle(.insetGrouped)
            .searchable(text: $vm.search, placement: .navigationBarDrawer(displayMode: .always), prompt: "search")//para quedarse fija la toolBar
        }
        .animation(.default, value: vm.search)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AnimeVM.preview)//Conecta con la preview
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
                Text("\(anime.episodes)")
                    .foregroundColor(.red)
                    .bold()
                Text(anime.type.rawValue)
            }
            .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
    }
}



