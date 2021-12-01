// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

class RainUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(scale, forKey: "scale_" + flowModeKey)
            }
        }
    }
    
    @Published var length: Double {
        didSet {
            if length != oldValue {
                UserDefaults.standard.set(length, forKey: "length_" + flowModeKey)
            }
        }
    }
    
    @Published var step: Double {
        didSet {
            if step != oldValue {
                UserDefaults.standard.set(step, forKey: "step_" + flowModeKey)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        scale = UserDefaults.standard.double(forKey: "scale_" + flowModeKey)
        length = UserDefaults.standard.double(forKey: "length_" + flowModeKey)
        step = UserDefaults.standard.double(forKey: "step_" + flowModeKey)
        
        super.init(flowModeKey)
    }
}
