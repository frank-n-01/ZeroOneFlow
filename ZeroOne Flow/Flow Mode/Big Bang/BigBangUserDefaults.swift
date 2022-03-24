// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

class BigBangUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(scale, forKey: "scale_" + flowMode)
            }
        }
    }
    
    @Published var gap: Double {
        didSet {
            if gap != oldValue {
                UserDefaults.standard.set(gap, forKey: "gap_" + flowMode)
            }
        }
    }
    
    @Published var rotationAngle: Double {
        didSet {
            if rotationAngle != oldValue {
                UserDefaults.standard.set(rotationAngle, forKey: "rotation_angle_" + flowMode)
            }
        }
    }
    
    @Published var paddingVertical: Double {
        didSet {
            if paddingVertical != oldValue {
                UserDefaults.standard.set(paddingVertical, forKey: "padding_vertical_" + flowMode)
            }
        }
    }
    
    @Published var paddingHorizontal: Double {
        didSet {
            if paddingHorizontal != oldValue {
                UserDefaults.standard.set(paddingHorizontal, forKey: "padding_horizontal_" + flowMode)
            }
        }
    }
    
    @Published var is3D: Bool {
        didSet {
            if is3D != oldValue {
                UserDefaults.standard.set(is3D, forKey: "is_3D_" + flowMode)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        scale = UserDefaults.standard.double(forKey: "scale_" + flowModeKey)
        gap = UserDefaults.standard.double(forKey: "gap_" + flowModeKey)
        rotationAngle = UserDefaults.standard.double(forKey: "rotation_angle_" + flowModeKey)
        paddingVertical = UserDefaults.standard.double(forKey: "padding_vertical_" + flowModeKey)
        paddingHorizontal = UserDefaults.standard.double(forKey: "padding_horizontal_" + flowModeKey)
        is3D = UserDefaults.standard.bool(forKey: "is_3D_" + flowModeKey)
        
        super.init(flowModeKey)
    }
}
