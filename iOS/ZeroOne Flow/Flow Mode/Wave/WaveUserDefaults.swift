// Copyright © 2022 Ni Fu. All rights reserved.

import Foundation

class WaveUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(
                    scale, forKey: Keys.scale.rawValue + flowMode)
            }
        }
    }
    
    @Published var gap: Double {
        didSet {
            if gap != oldValue {
                UserDefaults.standard.set(
                    gap, forKey: Keys.gap.rawValue + flowMode)
            }
        }
    }
    
    @Published var amplitude: Double {
        didSet {
            if amplitude != oldValue {
                UserDefaults.standard.set(
                    amplitude, forKey: Keys.amplitude.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        scale = UserDefaults.standard.double(forKey: Keys.scale.rawValue + flowModeKey)
        gap = UserDefaults.standard.double(forKey: Keys.gap.rawValue + flowModeKey)
        amplitude = UserDefaults.standard.double(forKey: Keys.amplitude.rawValue + flowModeKey)
        
        super.init(flowModeKey)
    }
    
    private enum Keys: String {
        case scale = "scale_"
        case gap = "gap_"
        case amplitude = "amplitude_"
    }
}
