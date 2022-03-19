// Copyright © 2021-22 Ni Fu. All rights reserved.

import SwiftUI

class ModeUserDefaults: ObservableObject {
    
    /// Enable access to the current mode from everywhere.
    static var sharedCurrentMode = 0
    
    static let CURRENT_MODE_KEY = "current_mode"
    
    static let IS_RANDOM_STYLE_KEY = "is_random_style"
    
    @Published var flowMode: Mode {
        didSet {
            UserDefaults.standard.set(flowMode.rawValue,
                                      forKey: Self.CURRENT_MODE_KEY)
            ModeUserDefaults.sharedCurrentMode = flowMode.rawValue
        }
    }
    
    @Published var isRandomStyle: Bool {
        didSet {
            UserDefaults.standard.set(isRandomStyle,
                                      forKey: Self.IS_RANDOM_STYLE_KEY)
        }
    }
    
    init() {
        self.flowMode = Mode(rawValue: UserDefaults.standard
            .integer(forKey: Self.CURRENT_MODE_KEY)) ?? .linear
        isRandomStyle = UserDefaults.standard
            .bool(forKey: Self.IS_RANDOM_STYLE_KEY)
        Self.sharedCurrentMode = flowMode.rawValue
    }
}
