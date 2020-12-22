//
//  EpisodesListRowView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 21/12/2020.
//

import SwiftUI

struct EpisodesListRowView: View {
    let episode: EpisodeDetail
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(episode.name ?? "Loading...")
                    .foregroundColor(.accentColor)
                Text(episode.episode ?? "Loading...")
                    .font(.footnote)
            }
            Spacer()
            Text(episode.airDate ?? "Loading...")
                .foregroundColor(.gray)
                .font(.footnote)
        }.redacted(reason: episode.name == nil ? .placeholder : [])
    }
}
