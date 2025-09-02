//
//  LocationsViewModel.swift
//  dotcom
//
//  Created by arsal on 9/2/25.
//

import Foundation

class LocationViewModel: ObservableObject {
    @Published var locations: [Location]

    init() {
        let data = LocationsDataService.locations
        self.locations = data
    }
}
