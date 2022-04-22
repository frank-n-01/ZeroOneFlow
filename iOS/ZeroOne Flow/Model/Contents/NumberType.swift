// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

enum NumberType: Int, CaseIterable, Equatable, Identifiable {
    case binary
    case octal
    case hexadecimal
    
    var id: UUID { return UUID() }
    
    var name: LocalizedStringKey {
        switch self {
        case .binary:
            return "Binary"
        case .octal:
            return "Oct"
        case .hexadecimal:
            return "Hex"
        }
    }
}
