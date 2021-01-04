//
//  CharacterListRowView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 21/12/2020.
//

import SwiftUI
import KingfisherSwiftUI

struct CharactersListRowView: View {
    let character: CharacterSmall
    
    var body: some View {
        HStack {
            if let image = character.image,
               let url = URL(string: image) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
            } else {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading) {
                Text(character.name ?? "Loading...")
                    .font(.title3)
                    .foregroundColor(.accentColor)
                    .redacted(reason: character.name == nil ? .placeholder : [])
                Text("\(character.episode?.count ?? 0) episode(s)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .redacted(reason: character.episode == nil ? .placeholder : [])
            }
        }
    }
}

struct CharacterListRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CharactersListRowView(character: .init(id: nil,
                                                   name: nil,
                                                   image: nil,
                                                   episode: nil))
            CharactersListRowView(character: .init(id: nil,
                                                   name: "preview",
                                                   image: nil,
                                                   episode: nil))
        }
    }
}
