// Copyright © 2021-2022 Ni Fu. All rights reserved.

import Foundation

class LinearUserDefaults: FlowModeUserDefaults {
    
    @Published var isRepeat: Bool {
        didSet {
            if isRepeat != oldValue {
                UserDefaults.standard
                    .set(isRepeat,
                         forKey: Keys.isRepeat.rawValue + flowMode)
            }
        }
    }
    
    @Published var isLineFeedOn: Bool {
        didSet {
            if isLineFeedOn != oldValue {
                UserDefaults.standard
                    .set(isLineFeedOn,
                         forKey: Keys.isLineFeedOn.rawValue + flowMode)
            }
        }
    }
    
    @Published var maxLineLength: Double {
        didSet {
            if maxLineLength != oldValue {
                UserDefaults.standard
                    .set(maxLineLength,
                         forKey: Keys.maxLineLength.rawValue + flowMode)
            }
        }
    }
    
    @Published var isIndentOn: Bool {
        didSet {
            if isIndentOn != oldValue {
                UserDefaults.standard
                    .set(isIndentOn,
                         forKey: Keys.isIndentOn.rawValue + flowMode)
            }
        }
    }
    
    @Published var maxNumberOfIndents: Double {
        didSet {
            if maxNumberOfIndents != oldValue {
                UserDefaults.standard
                    .set(maxNumberOfIndents,
                         forKey: Keys.maxNumberOfIndents.rawValue + flowMode)
            }
        }
    }
    
    override init(_ flowMode: String) {
        isRepeat = UserDefaults.standard.bool(forKey: Keys.isRepeat.rawValue + flowMode)
        isLineFeedOn = UserDefaults.standard.bool(forKey: Keys.isLineFeedOn.rawValue + flowMode)
        maxLineLength = UserDefaults.standard.double(forKey: Keys.maxLineLength.rawValue + flowMode)
        isIndentOn = UserDefaults.standard.bool(forKey: Keys.isIndentOn.rawValue + flowMode)
        maxNumberOfIndents = UserDefaults.standard.double(forKey: Keys.maxNumberOfIndents.rawValue + flowMode)
        
        super.init(flowMode)
    }
    
    private enum Keys: String {
        case isRepeat = "Repeat_"
        case isLineFeedOn = "isLineFeedOn_"
        case maxLineLength = "maxLineLength_"
        case isIndentOn = "is_indent_on_"
        case maxNumberOfIndents = "max_number_of_indents_"
    }
}
