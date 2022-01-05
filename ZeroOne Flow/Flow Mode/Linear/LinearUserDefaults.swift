// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Linear mode's UserDefaults properties.
class LinearUserDefaults: FlowModeUserDefaults {
    
    @Published var repeatFlow: Bool {
        didSet {
            if repeatFlow != oldValue {
                UserDefaults.standard.set(repeatFlow, forKey: "Repeat_" + flowModeKey)
            }
        }
    }
    
    @Published var isLineFeedOn: Bool {
        didSet {
            if isLineFeedOn != oldValue {
                UserDefaults.standard.set(isLineFeedOn, forKey: "isLineFeedOn_" + flowModeKey)
            }
        }
    }
    
    @Published var maxLineLength: Double {
        didSet {
            if maxLineLength != oldValue {
                UserDefaults.standard.set(maxLineLength, forKey: "maxLineLength_" + flowModeKey)
            }
        }
    }
    
    @Published var isIndentOn: Bool {
        didSet {
            if isIndentOn != oldValue {
                UserDefaults.standard.set(isIndentOn, forKey: "is_indent_on_" + flowModeKey)
            }
        }
    }
    
    @Published var maxNumberOfIndents: Double {
        didSet {
            if maxNumberOfIndents != oldValue {
                UserDefaults.standard
                    .set(maxNumberOfIndents, forKey: "max_number_of_indents_" + flowModeKey)
            }
        }
    }
    
    override init(_ flowModeKey: String) {
        repeatFlow = UserDefaults.standard.bool(forKey: "Repeat_" + flowModeKey)
        isLineFeedOn = UserDefaults.standard.bool(forKey: "isLineFeedOn_" + flowModeKey)
        maxLineLength = UserDefaults.standard.double(forKey: "maxLineLength_" + flowModeKey)
        isIndentOn = UserDefaults.standard.bool(forKey: "is_indent_on_" + flowModeKey)
        maxNumberOfIndents = UserDefaults.standard.double(forKey: "max_number_of_indents_" + flowModeKey)
        
        super.init(flowModeKey)
    }
}
