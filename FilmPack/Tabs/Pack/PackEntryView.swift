//
//  PackEntryView.swift
//  FilmPack
//
//  Created by Aaron Villalobos on 6/13/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PackEntryView: View {
    @State private var title : String = ""
    @State private var caption : String = ""
    @State private var imageData: [UIImage] = []
    @State private var newImages: [PhotosPickerItem] = []
    @State private var isShowingCancelOnConfirmation = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .foregroundStyle(Color.filmWhite)
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Create a FilmPack")
                        .bold()
                        .foregroundStyle(Color.filmWhite)
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
                    .disabled(title.isEmpty)
                }
            }
            .background(Color.pacific)
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
            TextField(text: $title) {
                Text("Title (Required)")
                    .foregroundStyle(Color.filmWhite)

            }
            .font(.title.bold())
            .padding(.top, 48)
            
            Divider()
            
            TextField(
                "",
                text: $caption,
                prompt: Text("Add a caption to your FilmPack")
                    .foregroundStyle(Color.filmWhite)
                    .bold(),
                axis: .vertical,
            )
                .multilineTextAlignment(.leading)
                .lineLimit(5...Int.max)
                .foregroundStyle(Color.filmWhite)
            
            PhotoPicker
        }
        .padding()
    }
}

#Preview {
    PackEntryView()
        .sampleDataContainer()
}
