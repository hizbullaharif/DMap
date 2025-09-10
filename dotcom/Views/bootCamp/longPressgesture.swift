import SwiftUI

struct LongPressGestureView: View { // Fixed naming convention (capitalized)

    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 50)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)

            Text("Click ME")
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                    // This is the completion handler - called when long press succeeds
                    withAnimation(.easeInOut(duration: 1.0)) {
                        isComplete = true
                        isSuccess = true
                    }
                } onPressingChanged: { isPressing in
                    // This handles the pressing state changes
                    if isPressing {
                        // Press started
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isComplete = true
                        }
                    } else {
                        // Press ended/cancelled before completion
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isComplete = false
                            isSuccess = false
                        }
                    }
                }
            Spacer()
        }
    }
}

#Preview {
    LongPressGestureView()
}
