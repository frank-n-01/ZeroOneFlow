// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

class SingleUserDefaults: FlowModeUserDefaults {
    
    @Published var gradientType: GradientType {
        didSet {
            if gradientType != oldValue {
                UserDefaults.standard.set(gradientType.rawValue, forKey: "gradient_type_" + flowModeKey)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        gradientType = GradientType(rawValue: UserDefaults.standard.integer(forKey: "gradient_type_" + flowModeKey)) ?? .radial
        super.init(flowModeKey)
    }
}
