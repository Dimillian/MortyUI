//
//  Network.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 18/12/2020.
//

import CoreData
import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
}
