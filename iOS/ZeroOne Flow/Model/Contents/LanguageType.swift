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
    
    /// Contains natural language words or not.
    /// Return false if it only has characters,
    var hasWords: Bool {
        switch self {
        case .latin:
            return false
        case .cuneiform:
            return false
        case .greek:
            return false
        case .hieroglyph:
            return false
        case .arabic:
            return false
        case .devanagari:
            return false
        case .chinese:
            return false
        case .english:
            return true
        case .japanese:
            return true
        case .spanish:
            return true
        }
    }
    
    /// Is a space necessary between words or cahracters.
    var hasSpaceBetweenWords: Bool {
        switch self {
        case .latin:
            return false
        case .cuneiform:
            return true
        case .greek:
            return false
        case .hieroglyph:
            return true
        case .arabic:
            return false
        case .devanagari:
            return false
        case .chinese:
            return false
        case .english:
            return true
        case .japanese:
            return false
        case .spanish:
            return true
        }
    }
}
