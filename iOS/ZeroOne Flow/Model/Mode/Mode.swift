// Copyright © 2021-2022 Ni Fu. All rights reserved.

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
    case snow
    case wave
    
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
        case .snow:
            return "Snow"
        case .wave:
            return "Wave"
        }
    }
    
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
        case .snow:
            return "Snow"
        case .wave:
            return "Wave"
        }
    }
    
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
        case .snow:
            return Snow.entity()
        case .wave:
            return Wave.entity()
        }
    }
    
    var image: String {
        switch self {
        case .linear:
            return "line.horizontal.3"
        case .fly:
            return "ladybug"
        case .tornado:
            return "tornado"
        case .single:
            return "paragraphsign"
        case .circle:
            return "circle.circle"
        case .worm:
            return "scribble.variable"
        case .bigbang:
            return "sun.max"
        case .rain:
            return "cloud.rain"
        case .snow:
            return "snow"
        case .wave:
            return "waveform.path.ecg"
        }
    }
}
