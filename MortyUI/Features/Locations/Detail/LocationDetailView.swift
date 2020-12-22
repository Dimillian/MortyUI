//
//  LocationDetailView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 22/12/2020.
//

import SwiftUI
import Apollo
import KingfisherSwiftUI

struct LocationDetailView: View {
    @StateObject private var query: SingleQuery<GetLocationQuery>
    
    init(id: GraphQLID) {
        _query = StateObject(wrappedValue: SingleQuery(query: GetLocationQuery(id: id)))
    }
    
    var body: some View {
        List {
            Section(header: Text("Info")) {
                InfoRowView(label: "Name",
                            icon: "info",
                            value: query.data?.location?.name ?? "loading...")
                InfoRowView(label: "Dimension",
                            icon: "tornado",
                            value: query.data?.location?.dimension ?? "loading...")
                InfoRowView(label: "Type",
                            icon: "newspaper",
                            value: query.data?.location?.type ?? "loading...")
            }.redacted(reason: query.data?.location == nil ? .placeholder : [])
            
            if let characters = query.data?.location?.residents?.compactMap{ $0 } {
                Section(header: Text("Residents")) {
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
        .navigationTitle(query.data?.location?.name ?? "")
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(id: GraphQLID(0))
    }
}
