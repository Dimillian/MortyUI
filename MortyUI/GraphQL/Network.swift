//
//  Network.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 18/12/2020.
//

import CoreData
import Apollo
import ApolloSQLite

class Network {
    static let shared = Network()
    private(set) lazy var apollo: ApolloClient = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true).first!
        let documentsURL = URL(fileURLWithPath: documentsPath)
        let sqliteFileURL = documentsURL.appendingPathComponent("db.sqlite")
        do {
            let sqliteCache = try SQLiteNormalizedCache(fileURL: sqliteFileURL)
            let store = ApolloStore(cache: sqliteCache)
            let network = RequestChainNetworkTransport(interceptorProvider: LegacyInterceptorProvider(store: store),
                                                       endpointURL: URL(string: "https://rickandmortyapi.com/graphql")!)
            return ApolloClient(networkTransport: network, store: store)
        } catch {
            return ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
        }
    }()
}
