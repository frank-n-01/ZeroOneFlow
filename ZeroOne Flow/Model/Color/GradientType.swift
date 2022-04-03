// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

enum GradientType: Int, CaseIterable, Equatable {
    case radial
    case linear
    case angular
    case elliptical
    
    var name: LocalizedStringKey {
        switch self {
        case .radial:
            return "Radial"
        case .linear:
            return "Linear.gradient"
        case .angular:
            return "Angular"
        case .elliptical:
            return "Elliptical"
        }
    }
}
