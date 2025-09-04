//
//  LocationsPreviewCard.swift
//  dotcom
//
//  Created by arsal on 9/3/25.
//

import SwiftUI

struct LocationsPreviewCard: View {
    @EnvironmentObject var locationVm: LocationViewModel

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            cityImageView
            Spacer()
            btns
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
        .transition(
            .asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading)
            )
        )
    }
}

#Preview {
    LocationsPreviewCard()
        .environmentObject(LocationViewModel())
        .background(Color.blue)
}

extension LocationsPreviewCard {
    private var cityImageView: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let imageName = locationVm.mapLocation.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(5)
                    .frame(width: 100, height: 100)
                    .padding(4)
                    .background(Color.white)
                    .cornerRadius(5)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(locationVm.mapLocation.name)
                    .font(.headline)
                Text(locationVm.mapLocation.cityName)
                    .font(.subheadline)
            }
        }
    }
    private var btns: some View {
        VStack(spacing: 8) {
            Button {
                locationVm.sheetLocation.toggle()
            } label: {
                Text("Learn More")
                    .frame(width: 125, height: 35)
            }
            .buttonStyle(.borderedProminent)

            Button {
                locationVm.nextBtnPresses()
            } label: {
                Text("Next")
                    .frame(width: 125, height: 30)

            }
            .buttonStyle(.bordered)
        }
    }
}
