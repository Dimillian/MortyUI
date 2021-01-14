//
//  SearchView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 04/01/2021.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        TextField("Search", text: $viewModel.searchText)
                        if !viewModel.searchText.isEmpty {
                            Button(action: {
                                viewModel.searchText = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                                to: nil,
                                                                from: nil,
                                                                for: nil)
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                            })
                        }
                    }
                }
                if let characters = viewModel.characters {
                    Section(header: Text("Characters")) {
                        ForEach(characters, id: \.id) { character in
                            NavigationLink(
                                destination: CharacterDetailView(id: character.id!),
                                label: {
                                    CharactersListRowView(character: character)
                                })
                        }
                    }
                }
                if let locations = viewModel.locations {
                    Section(header: Text("Locations")) {
                        ForEach(locations, id: \.id) { location in
                            NavigationLink(
                                destination: LocationDetailView(id: location.id!),
                                label: {
                                    LocationsListRowView(location: location)
                                })
                        }
                    }
                }
                if let episodes = viewModel.episodes {
                    Section(header: Text("Episodes")) {
                        ForEach(episodes, id: \.id) { episode in
                            NavigationLink(
                                destination: EpisodeDetailView(id: episode.id!),
                                label: {
                                    EpisodesListRowView(episode: episode)
                                })
                        }
                    }
                }
            }.navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
