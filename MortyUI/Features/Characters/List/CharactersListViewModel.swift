//
//  CharacterListViewModel.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 19/12/2020.
//

import Foundation
import SwiftUI
import Apollo

class CharacterListViewModel: ObservableObject {
    @Published public var characters: [CharacterSmall]?
    public var placeholders = Array(repeating: CharacterSmall(id: GraphQLID(0),
                                                              name: nil,
                                                              image: nil,
                                                              episode: nil), count: 10)
    
    public var currentPage = 1 {
        didSet {
            fetchCharacters()
        }
    }
    
    public var shouldDisplayNextPage: Bool {
        if characters?.isEmpty == false,
           let totalPages = totalPage,
           currentPage < totalPages {
            return true
        }
        return false
    }
    
    public private(set) var totalPage: Int?
    public private(set) var totalCharacters: Int?

    func fetchCharacters() {
        let fetchedPage = currentPage
        Network.shared.apollo.fetch(query: GetCharactersQuery(page: currentPage)) { [weak self] result in
            switch result {
            case .success(let result):
                if fetchedPage > 1 {
                    if let newCharacters = result.data?.characters?.results?.compactMap({ $0?.fragments.characterSmall }) {
                        self?.characters?.append(contentsOf: newCharacters)
                    }
                } else {
                    self?.characters = result.data?.characters?.results?.compactMap{ $0?.fragments.characterSmall }
                }
                self?.totalPage = result.data?.characters?.info?.pages
                self?.totalCharacters = result.data?.characters?.info?.count
        
            case .failure(let error):
                print("GraphQL query error: \(error)")
            }
        }
    }
}
