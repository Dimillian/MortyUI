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
                    TextField("Search", text: $viewModel.searchText)
                }
                if let characters = viewModel.characters {
                    Section(header: Text("Characters")) {
                        ForEach(characters, id: \.id) { character in
                            CharactersListRowView(character: character)
                        }
                    }
                }
                if let locations = viewModel.locations {
                    Section(header: Text("Locations")) {
                        ForEach(locations, id: \.id) { location in
                            LocationsListRowView(location: location)
                        }
                    }
                }
                if let episodes = viewModel.episodes {
                    Section(header: Text("Episodes")) {
                        ForEach(episodes, id: \.id) { episode in
                            EpisodesListRowView(episode: episode)
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
