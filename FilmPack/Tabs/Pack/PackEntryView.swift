//
//  PackEntryView.swift
//  FilmPack
//
//  Created by Aaron Villalobos on 6/13/26.
//

import SwiftUI
import PhotosUI
import SwiftData
import Combine

struct PackEntryView: View {
    @State private var title : String = ""
    @State private var caption : String = ""
    @State private var imageData: [UIImage] = []
    @State private var newImages: [PhotosPickerItem] = []
    @State private var isShowingCancelOnConfirmation = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
    
    let titleLimit = 20
    let captionLimit = 50
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .foregroundStyle(Color.pacific)
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Create a FilmPack")
                        .bold()
                        .foregroundStyle(Color.pacific)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        if title.isEmpty, caption.isEmpty, imageData == [] {
                            dismiss()
                        } else {
                            isShowingCancelOnConfirmation = true
                        }
                    }
                    .confirmationDialog("Discard Pack", isPresented: $isShowingCancelOnConfirmation) {
                        Button("Discard Pack", role: .destructive) {
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark") {
                        let newPack = Pack(
                            title: title,
                            caption: caption,
                            imageData: imageData,
                            timeStamp: .now
                        )
                        dataContainer.context.insert(newPack)
                        do {
                            try dataContainer.context.save()
                            dismiss()
                        } catch {
                            // Don't dismiss
                        }
                    }
                    .disabled(title.isEmpty || imageData.isEmpty)
                }
            }
            .background(Color.filmWhite)
        }
    }
    
    private var PhotoPicker: some View {
        VStack (spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack (spacing: 12) {
                    ForEach(imageData, id:\.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    PhotosPicker(selection: $newImages, maxSelectionCount: 8, matching: .images) {
                        Label("Select Polaroids", systemImage: "photo.badge.plus.fill")
                            .font(.title2)
                            .bold()
                            .imageScale(.large)
                            .buttonStyle(.borderedProminent)
                            .padding()
                    }
                    .frame(height: 250)
                    .padding()
                    .onChange(of: newImages) {
                        Task {
                            var images: [UIImage] = []
                            
                            for image in newImages {
                                if let data = try await image.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    images.append(uiImage)
                                }
                            }
                            await MainActor.run {
                                self.imageData = images
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 250)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    
    var contentStack: some View {
        VStack(alignment: .leading) {
            PhotoPicker
            TextField(text: $title) {
                Text("Title (Required)")
                    .foregroundStyle(Color.pacific)

            }
            .font(.title.bold())
            .padding(.top, 48)
            .onReceive(Just(title)) {_ in limitTitle(titleLimit)}
            
            Divider()
            
            TextField(
                "",
                text: $caption,
                prompt: Text("Add a caption to your FilmPack")
                    .foregroundStyle(Color.pacific)
                    .bold(),
                axis: .vertical,
            )
                .multilineTextAlignment(.leading)
                .lineLimit(5...Int.max)
                .foregroundStyle(Color.pacific)
                .onReceive(Just(caption)) {_ in limitCaption(captionLimit)}

            
        }
        .padding()
    }
    
    func limitTitle(_ upper: Int) {
        if title.count > upper {
            title = String(title.prefix(upper))
        }
    }
    
    func limitCaption(_ upper: Int) {
        if caption.count > upper {
            caption = String(caption.prefix(upper))
        }
    }
}

#Preview {
    PackEntryView()
        .sampleDataContainer()
}
