// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

enum SymbolType: Int, CaseIterable, Equatable, Identifiable {
    case box
    case currency
    case block
    case chess
    case mahjong
    case kaomoji
    
    var id: UUID { return UUID() }
    
    var name: LocalizedStringKey {
        switch self {
        case .box:
            return "Box"
        case .currency:
            return "Currency"
        case .block:
            return "Block"
        case .chess:
            return "Chess"
        case .mahjong:
            return "Mahjong"
        case .kaomoji:
            return "Kaomoji"
        }
    }
}
