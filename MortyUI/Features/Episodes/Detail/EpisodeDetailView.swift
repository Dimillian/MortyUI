//
//  EpisodeDetailView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 21/12/2020.
//

import SwiftUI
import Apollo
import KingfisherSwiftUI

struct EpisodeDetailView: View {
    public let id: GraphQLID
    
    @StateObject private var data = EpisodeDetailViewModel()
    
    var body: some View {
        List {
            Section(header: Text("Info")) {
                InfoRowView(label: "Name",
                            icon: "info",
                            value: data.episode?.name ?? "loading...")
                InfoRowView(label: "Air date",
                            icon: "calendar",
                            value: data.episode?.airDate ?? "loading...")
                InfoRowView(label: "Code",
                            icon: "barcode",
                            value: data.episode?.episode ?? "loading...")
            }.redacted(reason: data.episode == nil ? .placeholder : [])
            
            if let characters = data.episode?.characters?.compactMap{ $0 } {
                Section(header: Text("Characters")) {
                    ForEach(characters, id: \.id) { character in
                        NavigationLink(
                            destination: CharacterDetailView(id: character.id!),
                            label: {
                                HStack {
                                    if let image = character.image,
                                       let url = URL(string: image) {
                                        KFImage(url)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 28, height: 28)
                                            .cornerRadius(14)
                                    }
                                    Text(character.name!)
                                }
                            })
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear {
            data.id = id
        }
    }
}

struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailView(id: GraphQLID(0))
    }
}
