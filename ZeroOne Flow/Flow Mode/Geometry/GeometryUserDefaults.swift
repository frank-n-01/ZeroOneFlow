// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

class GeometryUserDefaults: FlowModeUserDefaults {
    
    @Published var shape: Int {
        didSet {
            if shape != oldValue {
                UserDefaults.standard.set(shape, forKey: "shape_" + flowModeKey)
            }
        }
    }
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(scale, forKey: "scale_" + flowModeKey)
            }
        }
    }
    
    @Published var isFill: Bool {
        didSet {
            if isFill != oldValue {
                UserDefaults.standard.set(isFill, forKey: "is_fill_" + flowModeKey)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        shape = UserDefaults.standard.integer(forKey: "shape_" + flowModeKey)
        scale = UserDefaults.standard.double(forKey: "scale_" + flowModeKey)
        isFill = UserDefaults.standard.bool(forKey: "is_fill_" + flowModeKey)
        
        super.init(flowModeKey)
    }
}
