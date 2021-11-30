// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

class WormUserDefaults: FlowModeUserDefaults {
    
    @Published var length: Double {
        didSet {
            if length != oldValue {
                UserDefaults.standard.set(length, forKey: "length_" + flowModeKey)
            }
        }
    }
    
    @Published var step: Double {
        didSet {
            if step != oldValue {
                UserDefaults.standard.set(step, forKey: "step_" + flowModeKey)
            }
        }
    }
    
    @Published var crawling: Double {
        didSet {
            if crawling != oldValue {
                UserDefaults.standard.set(crawling, forKey: "crawling_" + flowModeKey)
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
        length = UserDefaults.standard.double(forKey: "length_" + flowModeKey)
        step = UserDefaults.standard.double(forKey: "step_" + flowModeKey)
        crawling = UserDefaults.standard.double(forKey: "crawling_" + flowModeKey)
        paddingVertical = UserDefaults.standard.double(forKey: "padding_vertical_" + flowModeKey)
        paddingHorizontal = UserDefaults.standard.double(forKey: "padding_horizontal_" + flowModeKey)
        super.init(flowModeKey)
    }
}
