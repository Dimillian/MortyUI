//
//  CharacterDetailViewModel.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 19/12/2020.
//

import Foundation
import SwiftUI
import Apollo

class CharacterDetailViewModel: ObservableObject {
    @Published var character: GetCharacterQuery.Data.Character?
    
    public var id: GraphQLID? {
        didSet {
            if let id = id {
                loadCharacter(id: id)
            }
        }
    }
        
    func loadCharacter(id: GraphQLID) {
        Network.shared.apollo.fetch(query: GetCharacterQuery(id: id)) { result in
            switch result {
            case .success(let result):
                self.character = result.data?.character
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
