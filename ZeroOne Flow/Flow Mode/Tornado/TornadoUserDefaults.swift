// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

class TornadoUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(scale, forKey: "scale_" + flowMode)
            }
        }
    }
    
    @Published var durationMin: Double {
        didSet {
            if durationMin != oldValue {
                UserDefaults.standard.set(durationMin, forKey: "duration_min_" + flowMode)
            }
        }
    }
    
    @Published var durationMax: Double {
        didSet {
            if durationMax != oldValue {
                UserDefaults.standard.set(durationMax, forKey: "duration_max_" + flowMode)
            }
        }
    }
    
    @Published var angleMin: Double {
        didSet {
            if angleMin != oldValue {
                UserDefaults.standard.set(angleMin, forKey: "angle_min_" + flowMode)
            }
        }
    }
    
    @Published var angleMax: Double {
        didSet {
            if angleMax != oldValue {
                UserDefaults.standard.set(angleMax, forKey: "angle_max_" + flowMode)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        scale = UserDefaults.standard.double(forKey: "scale_" + flowModeKey)
        durationMin = UserDefaults.standard.double(forKey: "duration_min_" + flowModeKey)
        durationMax = UserDefaults.standard.double(forKey: "duration_max_" + flowModeKey)
        angleMin = UserDefaults.standard.double(forKey: "angle_min_" + flowModeKey)
        angleMax = UserDefaults.standard.double(forKey: "angle_max_" + flowModeKey)
        
        super.init(flowModeKey)
    }
}
