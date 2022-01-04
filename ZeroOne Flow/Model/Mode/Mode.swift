// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

enum Mode: Int, CaseIterable, Identifiable {
    case linear
    case fly
    case tornado
    case single
    case circle
    case worm
    case bigbang
    case rain
    
    var id: UUID {
        return UUID()
    }
    
    var name: LocalizedStringKey {
        switch self {
        case .linear:
            return "Linear"
        case .fly:
            return "Fly"
        case .tornado:
            return "Tornado"
        case .single:
            return "Single"
        case .circle:
            return "Circle"
        case .worm:
            return "Worm"
        case .bigbang:
            return "Big Bang"
        case .rain:
            return "Rain"
        }
    }
    
    /// User Defaults Key.
    var key: String {
        switch self {
        case .linear:
            return "Linear"
        case .fly:
            return "Fly"
        case .tornado:
            return "Tornado"
        case .single:
            return "Single"
        case .circle:
            return "Circle"
        case .worm:
            return "Worm"
        case .bigbang:
            return "BigBang"
        case .rain:
            return "Rain"
        }
    }
    
    /// Core Data Entity.
    var entity: NSEntityDescription {
        switch self {
        case .linear:
            return Linear.entity()
        case .fly:
            return Fly.entity()
        case .tornado:
            return Tornado.entity()
        case .single:
            return Single.entity()
        case .circle:
            return Circle.entity()
        case .worm:
            return Worm.entity()
        case .bigbang:
            return BigBang.entity()
        case .rain:
            return Rain.entity()
        }
    }
}
