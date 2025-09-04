//
//  LocationsViewModel.swift
//  dotcom
//
//  Created by arsal on 9/2/25.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {

    //  All locations
    @Published var locations: [Location]

    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()

    @Published var mapLocation: Location {
        didSet {
            self.setMapRegion(location: mapLocation)
        }
    }

    @Published var showLocationList: Bool = false

    @Published var sheetLocation: Bool = false

    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    init() {
        let data = LocationsDataService.locations
        self.locations = data
        self.mapLocation = data.first!

        self.setMapRegion(location: data.first!)
    }

    private func setMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            )
        }

    }

    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }

    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            self.mapLocation = location
            self.toggleLocationList()
        }
    }

    func nextBtnPresses() {
        if let index = locations.firstIndex(of: mapLocation) {
            let nextIndex = (index + 1) % locations.count
            withAnimation(.easeInOut) {
                self.mapLocation = locations[nextIndex]
            }
        }
    }

}
