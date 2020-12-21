//
//  EpisodesListView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 21/12/2020.
//

import SwiftUI

struct EpisodesListView: View {
    @StateObject private var data = EpisodesListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.episodes ?? data.placeholders, id: \.id) { episode in
                    NavigationLink(
                        destination: EpisodeDetailView(id: episode.id!),
                        label: {
                            EpisodesListRowView(episode: episode)
                        })
                }
                if data.shouldDisplayNextPage {
                    nextPageView
                }
            }
            .navigationTitle("Episodes")
            .onAppear {
                data.fetchEpisodes()
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

struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView()
    }
}
