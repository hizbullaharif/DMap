//
//  LocationListView.swift
//  dotcom
//
//  Created by arsal on 9/3/25.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var locationVm: LocationViewModel

    var body: some View {

        List {
            ForEach(locationVm.locations) { location in

                Button {
                    locationVm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                        .padding(.vertical, 4)
                        .listRowBackground(Color.clear)
                }

            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationListView()
        .environmentObject(LocationViewModel())
}

extension LocationListView {

    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
