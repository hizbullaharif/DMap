//
//  LocationView.swift
//  dotcom
//
//  Created by arsal on 9/2/25.
//

import MapKit
import SwiftUI

struct LocationView: View {

    //    @StateObject private var locationsVM = LocationViewModel()
    @EnvironmentObject private var locationsVM: LocationViewModel

    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationViewModel())
}
