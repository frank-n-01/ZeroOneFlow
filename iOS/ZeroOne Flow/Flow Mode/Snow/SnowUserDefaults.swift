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
    
    @Published var step: Double {
        didSet {
            if step != oldValue {
                UserDefaults.standard.set(
                    step, forKey: Keys.step.rawValue + flowMode)
            }
        }
    }
    
    @Published var floating: Double {
        didSet {
            if floating != oldValue {
                UserDefaults.standard.set(
                    floating, forKey: Keys.floating.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        scale = UserDefaults.standard.double(forKey: Keys.scale.rawValue + flowModeKey)
        wind = UserDefaults.standard.double(forKey: Keys.windStrength.rawValue + flowModeKey)
        step = UserDefaults.standard.double(forKey: Keys.step.rawValue + flowModeKey)
        floating = UserDefaults.standard.double(forKey: Keys.floating.rawValue + flowModeKey)
        
        super.init(flowModeKey)
    }
    
    private enum Keys: String {
        case scale = "scale_"
        case windStrength = "wind_"
        case step = "step_"
        case floating = "floating_"
    }
}
