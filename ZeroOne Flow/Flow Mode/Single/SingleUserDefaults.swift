// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

class SingleUserDefaults: FlowModeUserDefaults {
    
    @Published var gradientType: GradientType {
        didSet {
            if gradientType != oldValue {
                UserDefaults.standard.set(
                    gradientType.rawValue, forKey: Keys.gradientType.rawValue + flowMode
                )
            }
        }
    }
    
    override init(_ flowMode: String) {
        gradientType = GradientType(rawValue: UserDefaults.standard.integer(
            forKey: Keys.gradientType.rawValue + flowMode)) ?? SingleViewModel.GRADIENT_TYPE
        
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case gradientType = "gradient_type_"
    }
}
