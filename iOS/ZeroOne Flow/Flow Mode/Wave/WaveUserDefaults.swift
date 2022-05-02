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
    
    @Published var paddingVertical: Double {
        didSet {
            if paddingVertical != oldValue {
                UserDefaults.standard.set(
                    paddingVertical, forKey: Keys.paddingVertical.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowMode: String) {
        scale = UserDefaults.standard.double(forKey: Keys.scale.rawValue + flowMode)
        gap = UserDefaults.standard.double(forKey: Keys.gap.rawValue + flowMode)
        amplitude = UserDefaults.standard.double(forKey: Keys.amplitude.rawValue + flowMode)
        paddingVertical = UserDefaults.standard.double(forKey: Keys.paddingVertical.rawValue + flowMode)
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case scale = "scale_"
        case gap = "gap_"
        case amplitude = "amplitude_"
        case paddingVertical = "padding_vertical_"
    }
}
