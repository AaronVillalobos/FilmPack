import SwiftUI

enum FilmShieldLayout {
    case standard
    case large
    
    var size: CGFloat {
        switch self {
        case .standard:
            return 400.0
        case .large:
            return 450.0
        }
        
    }
    
    var timestampBottomPadding: CGFloat {
        0.08
    }
    
    var textBottomPadding: CGFloat {
        0.25
    }
    
    var timestampHeight: CGFloat {
        size * (textBottomPadding - timestampBottomPadding)
    }
    
    var titleFont: Font {
        switch self {
        case .standard:
            return .headline
        case .large:
            return .title.bold()
        }
    }
    
    var bodyFont: Font {
        switch self {
        case .standard:
            return .caption2
        case .large:
            return .body
        }
    }
}
