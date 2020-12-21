//
//  InfoRowView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 21/12/2020.
//

import SwiftUI

struct InfoRowView: View {
    let label: String
    let icon: String
    let value: String
    
    var body: some View {
        HStack {
            Label(label, systemImage: icon)
            Spacer()
            Text(value)
                .foregroundColor(.accentColor)
                .fontWeight(.semibold)
        }
    }
}
