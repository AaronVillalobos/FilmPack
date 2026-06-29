import Foundation
import SwiftData
import UIKit

@Model
class Pack {
    var title: String
    var caption: String
    var imageData: [Data]
    var timeStamp: Date
    
    init(title: String, caption: String, imageData: [UIImage] = [], timeStamp: Date = .now) {
        self.title = title
        self.caption = caption
        self.imageData = imageData.compactMap{$0.pngData()}
        self.timeStamp = timeStamp
    }

    var images: [UIImage] {
        imageData.compactMap {UIImage(data: $0)}
    }
}

extension Pack {
    static let sample = sampleData[0]
    
    static let sampleData = [
        Pack(
            title: "Launch Night",
            caption: "A successful launch night.",
            imageData: ["launch_2", "launch_1"].compactMap{
                UIImage(named: $0)
            }
        )
    ]
}
