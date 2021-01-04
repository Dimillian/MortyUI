//
//  SearchViewModel.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 04/01/2021.
//

import Foundation
import SwiftUI
import Apollo

class SearchViewModel: ObservableObject {
    @Published var searchText = "" {
        didSet {
            guard searchText != "" else {
                characters = nil
                locations = nil
                episodes = nil
                return
            }
            
            characters = Array(repeating: CharacterSmall(id: GraphQLID(0), name: nil, image: nil, episode: nil),
                               count: 3)
            locations = Array(repeating: LocationDetail(id: GraphQLID(0), name: nil, type: nil, dimension: nil, residents: nil),
                              count: 3)
            episodes = Array(repeating: EpisodeDetail(id: GraphQLID(0), name: nil, created: nil, airDate: nil, episode: nil,
                                                      characters: nil), count: 3)
            
            fetchSearch()
        }
    }
    
    @Published var characters: [CharacterSmall]?
    @Published var locations: [LocationDetail]?
    @Published var episodes: [EpisodeDetail]?
    
    func fetchSearch() {
        Network.shared.apollo.fetch(query: GetSearchQuery(name: searchText)) { [weak self] result in
            switch result {
            case .success(let result):
                self?.characters = result.data?.characters?.results?.compactMap{ $0?.fragments.characterSmall }.prefix(5).map{ $0}
                self?.locations = result.data?.locations?.results?.compactMap{ $0?.fragments.locationDetail }.prefix(5).map{ $0}
                self?.episodes = result.data?.episodes?.results?.compactMap{ $0?.fragments.episodeDetail }.prefix(5).map{ $0}
                
            case .failure(let error):
                print("GraphQL query error: \(error)")
            }
        }
    }
}
