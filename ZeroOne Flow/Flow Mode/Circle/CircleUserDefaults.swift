// Copyright © 2021-2022 Ni Fu. All rights reserved.

import Foundation

class CircleUserDefaults: FlowModeUserDefaults {
    
    @Published var depth: Double {
        didSet {
            if depth != oldValue {
                UserDefaults.standard.set(depth, forKey: Keys.depth.rawValue + flowMode)
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
    
    override init(_ flowMode: String) {
        depth = UserDefaults.standard.double(forKey: Keys.depth.rawValue + flowMode)
        gap = UserDefaults.standard.double(forKey: Keys.gap.rawValue + flowMode)
        rotationAngle = UserDefaults.standard
            .double(forKey: Keys.rotationAngle.rawValue + flowMode)
        
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case depth = "depth_"
        case gap = "gap_"
        case rotationAngle = "rotation_angle_"
    }
}
