// Copyright © 2021-2022 Ni Fu. All rights reserved.

import Foundation

class RainUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(scale, forKey: Keys.scale.rawValue + flowMode)
            }
        }
    }
    
    @Published var length: Double {
        didSet {
            if length != oldValue {
                UserDefaults.standard.set(length, forKey: Keys.length.rawValue + flowMode)
            }
        }
    }
    
    @Published var step: Double {
        didSet {
            if step != oldValue {
                UserDefaults.standard.set(step, forKey: Keys.step.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowMode: String) {
        scale = UserDefaults.standard.double(forKey: Keys.scale.rawValue + flowMode)
        length = UserDefaults.standard.double(forKey: Keys.length.rawValue + flowMode)
        step = UserDefaults.standard.double(forKey: Keys.step.rawValue + flowMode)
        
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case scale = "scale_"
        case length = "length_"
        case step = "step_"
    }
}
