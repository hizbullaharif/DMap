//
//  LocationDetailsView.swift
//  dotcom
//
//  Created by arsal on 9/4/25.
//

import MapKit
import SwiftUI

struct LocationDetailsView: View {
    let location: Location

    @EnvironmentObject var locationViewModel: LocationViewModel

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack {
                ImageCaroudal
                VStack(alignment: .leading, spacing: 16) {
                    Title
                    Divider()
                    Description

                    mapLayer
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(30)
                        .allowsHitTesting(false)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)

    }
}

#Preview {
    LocationDetailsView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationViewModel())
}

extension LocationDetailsView {
    private var ImageCaroudal: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
        .shadow(
            color: Color.black.opacity(0.3),
            radius: 20,
            x: 0,
            y: 10
        )
    }

    private var Title: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    private var Description: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Link(destination: URL(string: location.link)!) {
                Text("Read more...")
                    .font(.caption)
                    .foregroundColor(Color.blue)
            }

        }
    }
    private var mapLayer: some View {
        Map(
            coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: location.coordinates,
                    span: locationViewModel.mapSpan
                )
            ),
            annotationItems: [locationViewModel.mapLocation]
        ) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .padding()
        }
    }
}
