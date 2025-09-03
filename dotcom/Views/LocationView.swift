//
//  LocationView.swift
//  dotcom
//
//  Created by arsal on 9/2/25.
//

import MapKit
import SwiftUI

struct LocationView: View {

    @EnvironmentObject private var locationsVM: LocationViewModel

    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationsVM.mapRegion)
                .ignoresSafeArea()

            VStack {
                header
                    .padding()

                Spacer()

                ZStack {
                    ForEach(locationsVM.locations) {
                        location in
                        if locationsVM.mapLocation == location {
                            LocationsPreviewCard()
                                .shadow(
                                    color: Color.black.opacity(0.3),
                                    radius: 20
                                )
                                .padding(20)
                        }

                    }
                }
            }

        }

    }
}

extension LocationView {
    private var header: some View {
        VStack(spacing: 0) {

            Button {
                locationsVM.toggleLocationList()
            } label: {
                Text(
                    locationsVM.mapLocation.name + ", "
                        + locationsVM.mapLocation.cityName
                )
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .rotationEffect(
                            Angle(
                                degrees: locationsVM.showLocationList ? 180 : 0
                            )
                        )
                }
            }

            if locationsVM.showLocationList {
                LocationListView()
            }

        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 2)
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationViewModel())
}
