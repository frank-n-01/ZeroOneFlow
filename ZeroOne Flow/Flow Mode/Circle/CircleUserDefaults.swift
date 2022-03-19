// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

class CircleUserDefaults: FlowModeUserDefaults {
    
    @Published var depth: Double {
        didSet {
            if depth != oldValue {
                UserDefaults.standard.set(depth, forKey: "depth_" + flowMode)
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
    
    override init(_ flowModeKey: String) {
        depth = UserDefaults.standard.double(forKey: "depth_" + flowModeKey)
        gap = UserDefaults.standard.double(forKey: "gap_" + flowModeKey)
        rotationAngle = UserDefaults.standard.double(forKey: "rotation_angle_" + flowModeKey)
        
        super.init(flowModeKey)
    }
}
