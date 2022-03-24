// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

class FlyUserDefaults: FlowModeUserDefaults {
    
    @Published var scale: Double {
        didSet {
            if scale != oldValue {
                UserDefaults.standard
                    .set(scale, forKey: Keys.scale.rawValue + flowMode)
            }
        }
    }
    
    @Published var paddingVertical: Double {
        didSet {
            if paddingVertical != oldValue {
                UserDefaults.standard
                    .set(paddingVertical,
                         forKey: Keys.paddingVertical.rawValue + flowMode)
            }
        }
    }
    
    @Published var paddingHorizontal: Double {
        didSet {
            if paddingHorizontal != oldValue {
                UserDefaults.standard
                    .set(paddingHorizontal,
                         forKey: Keys.paddingHorizontal.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowMode: String) {
        scale = UserDefaults.standard
            .double(forKey: Keys.scale.rawValue + flowMode)
        paddingVertical = UserDefaults.standard
            .double(forKey: Keys.paddingVertical.rawValue + flowMode)
        paddingHorizontal = UserDefaults.standard
            .double(forKey: Keys.paddingHorizontal.rawValue + flowMode)
        
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case scale = "flies_"
        case paddingVertical = "padding_vertical_"
        case paddingHorizontal = "padding_horizontal_"
    }
}
