// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

class FlyUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard.set(scale, forKey: "flies_" + flowModeKey)
            }
        }
    }
    
    @Published var paddingVertical: Double {
        didSet {
            if paddingVertical != oldValue {
                UserDefaults.standard.set(paddingVertical, forKey: "padding_vertical_" + flowModeKey)
            }
        }
    }
    
    @Published var paddingHorizontal: Double {
        didSet {
            if paddingHorizontal != oldValue {
                UserDefaults.standard.set(paddingHorizontal, forKey: "padding_horizontal_" + flowModeKey)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        scale = UserDefaults.standard.double(forKey: "flies_" + flowModeKey)
        paddingVertical = UserDefaults.standard.double(forKey: "padding_vertical_" + flowModeKey)
        paddingHorizontal = UserDefaults.standard.double(forKey: "padding_horizontal_" + flowModeKey)
        super.init(flowModeKey)
    }
}
