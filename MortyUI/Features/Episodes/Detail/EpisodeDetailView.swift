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
    @StateObject private var query: SingleQuery<GetEpisodeQuery>
    
    init(id: GraphQLID) {
        _query = StateObject(wrappedValue: SingleQuery(query: GetEpisodeQuery(id: id)))
    }
    
    var episode: EpisodeDetail? {
        query.data?.episode?.fragments.episodeDetail
    }
    
    var body: some View {
        List {
            Section(header: Text("Info")) {
                InfoRowView(label: "Name",
                            icon: "info",
                            value: episode?.name ?? "loading...")
                InfoRowView(label: "Air date",
                            icon: "calendar",
                            value: episode?.airDate ?? "loading...")
                InfoRowView(label: "Code",
                            icon: "barcode",
                            value: episode?.episode ?? "loading...")
            }.redacted(reason: episode == nil ? .placeholder : [])
            
            if let characters = episode?.characters?.compactMap{ $0 } {
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
    }
}

struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailView(id: GraphQLID(0))
    }
}
