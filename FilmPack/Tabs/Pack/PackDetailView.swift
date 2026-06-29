
import SwiftUI
import SwiftData

struct PackDetailView: View {
    var pack: Pack
    @State private var showConfirmation = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(pack.title)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
                .foregroundStyle(Color.pacific)
            
            ScrollView {
                contentStack
            }
            .foregroundStyle(Color.filmWhite)
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button {
                        showConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .confirmationDialog("Delete Pack", isPresented: $showConfirmation) {
                        Button ("Delete Pack", role: .destructive){
                            dataContainer.context.delete(pack)
                            try? dataContainer.context.save()
                            dismiss()
                        }
                    } message: {
                        Text("The film pack will be permanently deleted.")
                    }
                }
            }
        }
        .background(Color.jet)
    }
    private var contentStack: some View {
        VStack(alignment: .leading) {
            Text(pack.timeStamp, style: .date)
                .font(.title3)
                .bold()
                .padding(.bottom, 12)
            
            ScrollView (.horizontal, showsIndicators: false) {
                LazyHStack (spacing: 12) {
                    ForEach(pack.images, id:\.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 450)

            if !pack.caption.isEmpty {
                Text(pack.caption)
                    .textSelection(.enabled)
                    .font(.default)
                    .bold()
                    .padding(.top, 12)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()        
    }
}

#Preview {
    NavigationStack {
        PackDetailView(pack: .sample)
            .sampleDataContainer()
    }
}
