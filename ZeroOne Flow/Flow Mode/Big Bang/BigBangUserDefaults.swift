// Copyright © 2021-2022 Ni Fu. All rights reserved.

import Foundation

class BigBangUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(scale, forKey: Keys.scale.rawValue + flowMode)
            }
        }
    }
    
    @Published var gap: Double {
        didSet {
            if gap != oldValue {
                UserDefaults.standard.set(gap, forKey: Keys.gap.rawValue + flowMode)
            }
        }
    }
    
    @Published var rotationAngle: Double {
        didSet {
            if rotationAngle != oldValue {
                UserDefaults.standard.set(
                    rotationAngle, forKey: Keys.rotationAngle.rawValue + flowMode)
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
    
    @Published var paddingHorizontal: Double {
        didSet {
            if paddingHorizontal != oldValue {
                UserDefaults.standard.set(
                    paddingHorizontal, forKey: Keys.paddingHorizontal.rawValue + flowMode)
            }
        }
    }
    
    @Published var is3D: Bool {
        didSet {
            if is3D != oldValue {
                UserDefaults.standard.set(is3D, forKey: Keys.is3D.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowMode: String) {
        scale = UserDefaults.standard.double(forKey: Keys.scale.rawValue + flowMode)
        gap = UserDefaults.standard.double(forKey: Keys.gap.rawValue + flowMode)
        rotationAngle = UserDefaults.standard
            .double(forKey: Keys.rotationAngle.rawValue + flowMode)
        paddingVertical = UserDefaults.standard
            .double(forKey: Keys.paddingVertical.rawValue + flowMode)
        paddingHorizontal = UserDefaults.standard
            .double(forKey: Keys.paddingHorizontal.rawValue + flowMode)
        is3D = UserDefaults.standard.bool(forKey: Keys.is3D.rawValue + flowMode)
        
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case scale = "scale_"
        case gap = "gap_"
        case rotationAngle = "rotation_angle_"
        case paddingVertical = "padding_vertical_"
        case paddingHorizontal = "padding_horizontal_"
        case is3D = "is_3D_"
    }
}
