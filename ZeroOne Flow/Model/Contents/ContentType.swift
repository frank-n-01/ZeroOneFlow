// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

enum ContentType: Int, CaseIterable, Equatable, Identifiable {
    case number
    case language
    case symbol
    case custom
    case code
    
    var id: UUID { return UUID() }
    
    static var allCasesWithoutCustom: [ContentType] {
        return [.number, .language, .symbol, .code]
    }
    
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
        case .code:
            return "Code"
        }
    }
}
