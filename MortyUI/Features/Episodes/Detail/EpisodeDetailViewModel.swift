//
//  EpisodeDetailViewModel.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 21/12/2020.
//

import Foundation
import Apollo

class EpisodeDetailViewModel: ObservableObject {
    @Published var episode: GetEpisodeQuery.Data.Episode?
    
    public var id: GraphQLID? {
        didSet {
            if let id = id {
                loadEpisode(id: id)
            }
        }
    }
    
    func loadEpisode(id: GraphQLID) {
        Network.shared.apollo.fetch(query: GetEpisodeQuery(id: id)) { result in
            switch result {
            case .success(let result):
                self.episode = result.data?.episode
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
