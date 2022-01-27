// Copyright © 2021-22 Ni Fu. All rights reserved.

import SwiftUI

/// Save the current mode in UserDefaults.
class ModeUserDefaults: ObservableObject {
    
    /// Enable access to the current mode from everywhere if necessary.
    static var currentMode = 0
    
    static let CURRENT_MODE = "current_mode"
    static let IS_RANDOM_STYLE = "is_random_style"
    
    /// The current flow mode.
    @Published var mode: Mode {
        didSet {
            UserDefaults.standard.set(mode.rawValue, forKey: Self.CURRENT_MODE)
            ModeUserDefaults.currentMode = mode.rawValue
        }
    }
    
    /// Is the random style mode activated.
    @Published var isRandomStyle: Bool {
        didSet {
            UserDefaults.standard.set(isRandomStyle, forKey: Self.IS_RANDOM_STYLE)
        }
    }
    
    init() {
        self.mode = Mode(rawValue: UserDefaults.standard
                            .integer(forKey: Self.CURRENT_MODE)) ?? .linear
        isRandomStyle = UserDefaults.standard.bool(forKey: Self.IS_RANDOM_STYLE)
        Self.currentMode = mode.rawValue
    }
}
