import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    init(includeSamplePack: Bool = false) {
        let schema = Schema([
            Pack.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSamplePack)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            if includeSamplePack {
                loadSamplePack()
            }
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer\(error)")
        }
    }
    
    private func loadSamplePack() {
        for pack in Pack.sampleData {
            context.insert(pack)
        }
    }
}

private let sampleContainer = DataContainer(includeSamplePack: true)

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelContainer)
    }
}
