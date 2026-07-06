import SwiftUI

struct FilmShieldPackView: View {
    var pack: Pack
    @State var layout: FilmShieldLayout = .large
    
    var body: some View {
        FilmShield(layout: layout, pack: pack) {
            filmShieldStack()
        }
        .padding()
        .background(Color.jet)
    }
    
    private func filmShieldStack() -> some View {
        ZStack(alignment: .bottomLeading) {
            Color.clear
            contentStack()
                .frame(maxWidth: 400)
                .padding()
        }
        .foregroundStyle(.pacific)
    }
    
    private func contentStack() -> some View {
        VStack(alignment: .center) {
            Text(pack.title)
                .font(.title3)
                .bold()
            Text(pack.timeStamp, style: .date)
                .bold()
        }
    }
}

#Preview {
    ScrollView {
        FilmShieldPackView(pack: Pack.sample)
        FilmShieldPackView(pack: Pack.sample)
        FilmShieldPackView(pack: Pack.sample)
    }
}
