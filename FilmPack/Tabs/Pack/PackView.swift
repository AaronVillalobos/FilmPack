import SwiftUI
import SwiftData

struct PackView: View {
    @State private var showCreatePack = false
    @Query(sort: \Pack.timeStamp)
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
                    } description: {
                        Text("Create a FilmPack to start seeing your captured moments.")
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
            }
            .navigationTitle("FilmPack")
        }
    }
    
    private var pathItems: some View {
        ForEach(packs) { pack in
            Text(pack.title)
        }
    }
}

#Preview {
    PackView()
        .sampleDataContainer()
}

#Preview("No film packs") {
    PackView()
        .modelContainer(for: [Pack.self])
}
