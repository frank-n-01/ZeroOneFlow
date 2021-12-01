// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Linear mode's UserDefaults properties.
class LinearUserDefaults: FlowModeUserDefaults {
    
    @Published var repeatFlow: Bool {
        didSet {
            if repeatFlow != oldValue {
                UserDefaults.standard.set(repeatFlow, forKey: "Repeat_" + flowModeKey)
            }
        }
    }
    
    @Published var isLineFeedOn: Bool {
        didSet {
            if isLineFeedOn != oldValue {
                UserDefaults.standard.set(isLineFeedOn, forKey: "isLineFeedOn_" + flowModeKey)
            }
        }
    }
    
    @Published var maxLineLength: Int {
        didSet {
            if maxLineLength != oldValue {
                UserDefaults.standard.set(maxLineLength, forKey: "maxLineLength_" + flowModeKey)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        repeatFlow = UserDefaults.standard.bool(forKey: "Repeat_" + flowModeKey)
        isLineFeedOn = UserDefaults.standard.bool(forKey: "isLineFeedOn_" + flowModeKey)
        maxLineLength = UserDefaults.standard.integer(forKey: "maxLineLength_" + flowModeKey)
        
        super.init(flowModeKey)
    }
}
