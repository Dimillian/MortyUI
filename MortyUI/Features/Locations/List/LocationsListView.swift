//
//  LocationsListView.swift
//  MortyUI
//
//  Created by Thomas Ricouard on 22/12/2020.
//

import SwiftUI

struct LocationsListView: View {
    @StateObject private var data = LocationsListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.locations ?? data.placeholders, id: \.id) { location in
                    NavigationLink(
                        destination: LocationDetailView(id: location.id!),
                        label: {
                            LocationsListRowView(location: location)
                        })
                }
                if data.shouldDisplayNextPage {
                    nextPageView
                }
            }
            .navigationTitle("Characters")
            .onAppear {
                data.fetchLocations()
            }
        }
    }
    
    private var nextPageView: some View {
        HStack {
            Spacer()
            VStack {
                ProgressView()
                Text("Loading next page...")
            }
            Spacer()
        }
        .onAppear(perform: {
            data.currentPage += 1
        })
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}
