//
//  LocationsListRowView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 22/12/2020.
//

import SwiftUI

struct LocationsListRowView: View {
    let location: LocationDetail
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(location.name ?? "Loading...")
                    .foregroundColor(.accentColor)
                Text("\(location.residents?.count ?? 0) resident(s)")
                    .font(.footnote)
            }
            Spacer()
            Text(location.dimension ?? "Loading...")
                .foregroundColor(.gray)
                .font(.footnote)
        }.redacted(reason: location.name == nil ? .placeholder : [])
    }
}
