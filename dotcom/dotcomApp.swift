//
//  dotcomApp.swift
//  dotcom
//
//  Created by arsal on 9/2/25.
//

import SwiftUI

@main
struct dotcomApp: App {

    @StateObject private var locaitonVM = LocationViewModel()

    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(locaitonVM)
        }
    }
}
