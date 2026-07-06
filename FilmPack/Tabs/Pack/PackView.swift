import SwiftUI
import SwiftData

struct PackView: View {
    @State private var showCreatePack = false
    @Query(sort: \Pack.timeStamp, order: .reverse)
    private var packs: [Pack]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                pathItems
                    .frame(maxWidth: .infinity)
            }
            .overlay {
                if packs.isEmpty {
                    ContentUnavailableView {
                        Label("No film packs yet!", systemImage: "exclamationmark.circle.fill")
                            .foregroundStyle(Color.filmWhite)
                    } description: {
                        Text("Create a FilmPack to start seeing your Polaroids.")
                            .foregroundStyle(Color.filmWhite)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showCreatePack = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showCreatePack) {
                        PackEntryView()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    HStack (spacing: 8) {
                        Text("FilmPack")
                            .font(.system(size: 32, weight: .bold, design: .default))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.oat)
                            .padding(.top, 10)
                    }
                }
                
            }
            .toolbarRole(.editor)
            .defaultScrollAnchor(.bottom, for: .initialOffset)
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
            .background(Color.jet)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var pathItems: some View {
        ForEach(packs) { pack in
            NavigationLink {
                PackDetailView(pack: pack)
            } label: {
                 FilmShieldPackView(pack: pack)
            }
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0)
                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                
            }
        }
    }
}

#Preview {
    PackView()
        .sampleDataContainer()
        .modelContainer(for: [Pack.self])
}

#Preview("No film packs") {
    PackView()
        .modelContainer(for: [Pack.self])
}
