//
//  LocationMapAnnotationView.swift
//  dotcom
//
//  Created by arsal on 9/3/25.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    var body: some View {
        VStack {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .cornerRadius(36)

            Image(systemName: "triangle.fill")
                .scaledToFit()
                .foregroundColor(Color.accentColor)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -10)
                .padding(.bottom, 40)

        }
    }
}

#Preview {
    LocationMapAnnotationView()
}
