//
//  SingleQuery.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 22/12/2020.
//

import Foundation
import Apollo
import SwiftUI

public class SingleQuery<Query: GraphQLQuery>: ObservableObject {
    @Published public var data: Query.Data?
    @Published public var error: Error?
    
    public init(query: Query) {
        loadData(query: query)
    }
    
    private func loadData(query: Query) {
        Network.shared.apollo.fetch(query: query) { [weak self] result in
            switch result {
            case .success(let result):
                self?.data = result.data
            case .failure(let error):
                self?.error = error
            }
        }
    }
}
