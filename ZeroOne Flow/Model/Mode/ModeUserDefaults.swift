// Copyright © 2021-22 Ni Fu. All rights reserved.

import SwiftUI

class ModeUserDefaults: ObservableObject {
    
    static var sharedCurrentMode = 0
    
    @Published var flowMode: Mode {
        didSet {
            UserDefaults.standard.set(flowMode.rawValue, forKey: Keys.currentMode.rawValue)
            ModeUserDefaults.sharedCurrentMode = flowMode.rawValue
        }
    }
    
    @Published var isRandomStyle: Bool {
        didSet {
            UserDefaults.standard.set(isRandomStyle, forKey: Keys.isRandomStyle.rawValue)
        }
    }
    
    init() {
        flowMode = Mode(rawValue: UserDefaults.standard
            .integer(forKey: Keys.currentMode.rawValue)) ?? .linear
        isRandomStyle = UserDefaults.standard.bool(forKey: Keys.isRandomStyle.rawValue)
        Self.sharedCurrentMode = flowMode.rawValue
    }
    
    private enum Keys: String {
        case currentMode = "current_mode"
        case isRandomStyle = "is_random_style"
    }
}
