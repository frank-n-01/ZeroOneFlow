// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

enum ContentType: Int, CaseIterable, Equatable, Identifiable {
    case number
    case language
    case symbol
    case custom
    
    var id: UUID { return UUID() }
    
    var name: LocalizedStringKey {
        switch self {
        case .number:
            return "Number"
        case .language:
            return "Language"
        case .symbol:
            return "Symbol"
        case .custom:
            return "Custom"
        }
    }
}
