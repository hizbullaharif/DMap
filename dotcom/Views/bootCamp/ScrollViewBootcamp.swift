import SwiftUI

struct ContentView: View {

    @State private var rating: Int = 1
    var body: some View {
        ZStack {
            StarsView
                .overlay(OverLayView.mask(StarsView))

        }
    }

    private var StarsView: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation (.easeInOut) {
                            rating = index + 1
                        }
                  
                    }
            }
        }
    }

    private var OverLayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsTightening(false)
    }
}

#Preview {
    ContentView()
}
