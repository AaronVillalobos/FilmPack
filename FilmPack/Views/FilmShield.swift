import SwiftUI

struct FilmShield<Content: View>: View {
    var layout: FilmShieldLayout = .standard
    var pack: Pack? = nil
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            if let background = pack?.images[0] {
                Image(uiImage: background)
                    .resizable()
                    .scaledToFit()
            }
            content()
                .frame(width: layout.size, height: layout.size)
        }
        .mask {
            Image(systemName: "rectangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: layout.size, height: layout.size)
        }
        .frame(width: layout.size, height: layout.size)
    }
}

#Preview {
    FilmShield(pack: Pack.sample) {
        Text(Pack.sample.title)
            .foregroundStyle(Color.black)
    }
    .sampleDataContainer()
}
