//
//  CharactersListView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 19/12/2020.
//

import SwiftUI
import KingfisherSwiftUI

struct CharactersListView: View {
    @StateObject private var data = CharacterListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.characters ?? data.placeholders, id: \.id) { character in
                    NavigationLink(
                        destination: CharacterDetailView(id: character.id!),
                        label: {
                            CharactersListRowView(character: character)
                        })
                }
                if data.shouldDisplayNextPage {
                    nextPageView
                }
            }
            .navigationTitle("Characters")
            .onAppear {
                data.fetchCharacters()
            }
        }
    }
    
    private var nextPageView: some View {
        HStack {
            Spacer()
            VStack {
                ProgressView()
                Text("Loading next page...")
            }
            Spacer()
        }
        .onAppear(perform: {
            data.currentPage += 1
        })
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
