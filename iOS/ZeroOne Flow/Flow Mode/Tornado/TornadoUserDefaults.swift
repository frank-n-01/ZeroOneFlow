// Copyright © 2021-2022 Ni Fu. All rights reserved.

import Foundation

class TornadoUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(
                    scale, forKey: Keys.scale.rawValue + flowMode)
            }
        }
    }
    
    @Published var durationMin: Double {
        didSet {
            if durationMin != oldValue {
                UserDefaults.standard.set(
                    durationMin, forKey: Keys.durationMin.rawValue + flowMode)
            }
        }
    }
    
    @Published var durationMax: Double {
        didSet {
            if durationMax != oldValue {
                UserDefaults.standard.set(
                    durationMax, forKey: Keys.durationMax.rawValue + flowMode)
            }
        }
    }
    
    @Published var angleMin: Double {
        didSet {
            if angleMin != oldValue {
                UserDefaults.standard.set(
                    angleMin, forKey: Keys.angleMin.rawValue + flowMode)
            }
        }
    }
    
    @Published var angleMax: Double {
        didSet {
            if angleMax != oldValue {
                UserDefaults.standard.set(
                    angleMax, forKey: Keys.angleMax.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowMode: String) {
        scale = UserDefaults.standard.double(forKey: Keys.scale.rawValue + flowMode)
        durationMin = UserDefaults.standard.double(forKey: Keys.durationMin.rawValue + flowMode)
        durationMax = UserDefaults.standard.double(forKey: Keys.durationMax.rawValue + flowMode)
        angleMin = UserDefaults.standard.double(forKey: Keys.angleMin.rawValue + flowMode)
        angleMax = UserDefaults.standard.double(forKey: Keys.angleMax.rawValue + flowMode)
        
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case scale = "scale_"
        case durationMin = "duration_min_"
        case durationMax = "duration_max_"
        case angleMin = "angle_min_"
        case angleMax = "angle_max_"
    }
}
