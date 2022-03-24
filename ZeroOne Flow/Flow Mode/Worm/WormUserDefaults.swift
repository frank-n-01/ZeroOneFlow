// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

class WormUserDefaults: FlowModeUserDefaults {
    
    @Published var length: Double {
        didSet {
            if length != oldValue {
                UserDefaults.standard.set(length, forKey: Keys.length.rawValue + flowMode)
            }
        }
    }
    
    @Published var step: Double {
        didSet {
            if step != oldValue {
                UserDefaults.standard.set(step, forKey: Keys.step.rawValue + flowMode)
            }
        }
    }
    
    @Published var crawling: Double {
        didSet {
            if crawling != oldValue {
                UserDefaults.standard.set(
                    crawling, forKey: Keys.crawling.rawValue + flowMode)
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
    
    override init(_ flowMode: String) {
        length = UserDefaults.standard
            .double(forKey: Keys.length.rawValue + flowMode)
        step = UserDefaults.standard
            .double(forKey: Keys.step.rawValue + flowMode)
        crawling = UserDefaults.standard
            .double(forKey: Keys.crawling.rawValue + flowMode)
        paddingVertical = UserDefaults.standard
            .double(forKey: Keys.paddingVertical.rawValue + flowMode)
        paddingHorizontal = UserDefaults.standard
            .double(forKey: Keys.paddingHorizontal.rawValue + flowMode)
        
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case length = "length_"
        case step = "step_"
        case crawling = "crawling_"
        case paddingVertical = "padding_vertical_"
        case paddingHorizontal = "padding_horizontal_"
    }
}
