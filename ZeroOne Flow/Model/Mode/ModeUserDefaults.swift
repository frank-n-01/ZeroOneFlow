// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Save the current mode in UserDefaults.
class ModeUserDefaults: ObservableObject {
    
    /// Enable access to the current mode from everywhere if necessary.
    static var currentMode = 0
    
    let KEY = "current_mode"
    
    @Published var mode: Mode {
        didSet {
            UserDefaults.standard.set(mode.rawValue, forKey: KEY)
            ModeUserDefaults.currentMode = mode.rawValue
        }
    }
    
    init() {
        self.mode = Mode(rawValue: UserDefaults.standard.integer(forKey: KEY)) ?? .linear
        Self.currentMode = mode.rawValue
    }
}
