// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

enum LanguageType: Int, CaseIterable, Equatable, Identifiable {
    case latin
    case cuneiform
    case greek
    case hieroglyph
    case arabic
    case devanagari
    case chinese
    case english
    case japanese
    case spanish
    
    var id: UUID { return UUID() }
    
    var name: LocalizedStringKey {
        switch self {
        case .latin:
            return "Latin"
        case .cuneiform:
            return "Cuneiform"
        case .greek:
            return "Greek"
        case .hieroglyph:
            return "Hieroglyph"
        case .arabic:
            return "Arabic"
        case .devanagari:
            return "Devanagari"
        case .chinese:
            return "Chinese"
        case .english:
            return "English"
        case .japanese:
            return "Japanese"
        case .spanish:
            return "Spanish"
        }
    }
}
