//  Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

enum CodeType: Int, CaseIterable, Equatable, Identifiable {
    case cobol
    case basic
    case c
    case sql
    case html
    
    var id: UUID { return UUID() }
    
    var name: LocalizedStringKey {
        switch self {
        case .cobol:
            return "COBOL"
        case .basic:
            return "BASIC"
        case .c:
            return "C"
        case .sql:
            return "SQL"
        case .html:
            return "HTML"
        }
    }
}
