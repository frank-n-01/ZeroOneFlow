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
        }
    }
    
    var comma: String {
        switch self {
        case .latin, .greek, .devanagari:
            return ", "
        case .cuneiform, .hieroglyph, .arabic:
            return ""
        case .chinese:
            return "，"
        }
    }
    
    var period: String {
        switch self {
        case .latin, .greek:
            return ". "
        case .cuneiform, .hieroglyph, .arabic:
            return ""
        case .devanagari:
            return " । "
        case .chinese:
            return "。"
        }
    }
    
    var indent: String {
        switch self {
        case .latin, .greek:
            return "\t"
        case .cuneiform, .hieroglyph, .devanagari, .arabic:
            return ""
        case .chinese:
            return "　　"
        }
    }
    
    var space: String {
        switch self {
        case .latin, .greek, .devanagari:
            return " "
        case .cuneiform, .hieroglyph, .arabic, .chinese:
            return ""
        }
    }
}
