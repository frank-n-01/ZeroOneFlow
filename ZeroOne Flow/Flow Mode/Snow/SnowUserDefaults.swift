// Copyright © 2022 Ni Fu. All rights reserved.

import Foundation

class SnowUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(
                    scale, forKey: Keys.scale.rawValue + flowMode)
            }
        }
    }
    
    @Published var wind: Double {
        didSet {
            if wind != oldValue {
                UserDefaults.standard.set(
                    wind, forKey: Keys.windStrength.rawValue + flowMode)
            }
        }
    }
    
    @Published var fall: Double {
        didSet {
            if fall != oldValue {
                UserDefaults.standard.set(
                    fall, forKey: Keys.step.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        scale = UserDefaults.standard.double(forKey: Keys.scale.rawValue + flowModeKey)
        wind = UserDefaults.standard.double(forKey: Keys.windStrength.rawValue + flowModeKey)
        fall = UserDefaults.standard.double(forKey: Keys.step.rawValue + flowModeKey)
        
        super.init(flowModeKey)
    }
    
    private enum Keys: String {
        case scale = "scale_"
        case windStrength = "wind_strength_"
        case step = "step_"
    }
}
