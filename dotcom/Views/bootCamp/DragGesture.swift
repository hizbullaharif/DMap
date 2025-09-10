//
//  DragGesture.swift
//  dotcom
//
//  Created by arsal on 9/9/25.
//

import SwiftUI

struct DragGestureView: View {
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.83
    @State private var currentDragOffsetY: CGFloat = 0
    
    // Define snap positions
    private let collapsedPosition: CGFloat = UIScreen.main.bounds.height * 0.83
    private let expandedPosition: CGFloat = UIScreen.main.bounds.height * 0.1
    private let dismissThreshold: CGFloat = UIScreen.main.bounds.height * 0.7
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            SignupView()
                .offset(y: startingOffsetY + currentDragOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Remove animation during drag for smoother interaction
                            currentDragOffsetY = value.translation.height
                        }
                        .onEnded { value in
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                let finalPosition = startingOffsetY + value.translation.height
                                let velocity = value.predictedEndLocation.y - value.location.y
                                
                                // Determine final position based on gesture
                                if finalPosition > dismissThreshold || velocity > 500 {
                                    // Snap to collapsed (original) position
                                    startingOffsetY = collapsedPosition
                                } else if finalPosition < expandedPosition || velocity < -500 {
                                    // Snap to expanded position
                                    startingOffsetY = expandedPosition
                                } else {
                                    // Snap to nearest position
                                    let distanceToCollapsed = abs(finalPosition - collapsedPosition)
                                    let distanceToExpanded = abs(finalPosition - expandedPosition)
                                    
                                    startingOffsetY = distanceToCollapsed < distanceToExpanded ?
                                        collapsedPosition : expandedPosition
                                }
                                
                                // Reset drag offset
                                currentDragOffsetY = 0
                            }
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestureView()
}

struct SignupView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Drag indicator
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.5))
                .frame(width: 40, height: 6)
                .padding(.top, 8)
            
            Image(systemName: "chevron.up")
                .font(.title2)
                .foregroundColor(.blue)
            
            Text("Signup View")
                .font(.title2)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
        )
    }
}
