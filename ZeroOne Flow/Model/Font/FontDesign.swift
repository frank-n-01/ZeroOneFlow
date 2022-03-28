// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

enum FontDesign: Int, CaseIterable, Identifiable {
    case defaultDesign
    case monospaced
    case rounded
    case serif
    case random
    
    static var allCasesWithoutRandom: [FontDesign] = [
        .defaultDesign, .monospaced, .rounded, .serif]
    
    var id: UUID {
        return UUID()
    }
    
    var name: LocalizedStringKey {
        switch self {
        case .defaultDesign:
            return "default"
        case .monospaced:
            return "monospaced"
        case .rounded:
            return "rounded"
        case .serif:
            return "serif"
        case .random:
            return "random"
        }
    }
    
    var value: Font.Design {
        switch self {
        case .defaultDesign:
            return .default
        case .monospaced:
            return .monospaced
        case .rounded:
            return .rounded
        case .serif:
            return .serif
        case .random:
            return Self.allCasesWithoutRandom.randomElement()?.value ?? .monospaced
        }
    }
}
