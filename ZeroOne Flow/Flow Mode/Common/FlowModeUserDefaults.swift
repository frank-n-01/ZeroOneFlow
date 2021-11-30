// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// The super class of the each flow mode's UserDefaults class.
class FlowModeUserDefaults: ObservableObject {
    
    @Published var flowModeKey: String
    
    @Published var fontSize: Double {
        didSet {
            if fontSize != oldValue {
                UserDefaults.standard.set(fontSize, forKey: "fontSize_" + flowModeKey)
            }
        }
    }
    
    @Published var fontSizeMin: Double {
        didSet {
            if fontSizeMin != oldValue {
                UserDefaults.standard.set(fontSizeMin, forKey: "fontSize_min_" + flowModeKey)
            }
        }
    }
    
    @Published var fontSizeMax: Double {
        didSet {
            if fontSizeMax != oldValue {
                UserDefaults.standard.set(fontSizeMax, forKey: "fontSize_max_" + flowModeKey)
            }
        }
    }
    
    @Published var fontDesign: Int {
        didSet {
            if fontDesign != oldValue {
                UserDefaults.standard.set(fontDesign, forKey: "fontDesign_" + flowModeKey)
            }
        }
    }
    
    @Published var fontWeight: Int {
        didSet {
            if fontWeight != oldValue {
                UserDefaults.standard.set(fontWeight, forKey: "fontWeight_" + flowModeKey)
            }
        }
    }
    
    @Published var txtR: Double {
        didSet {
            if txtR != oldValue {
                UserDefaults.standard.set(txtR, forKey: "txtColor_R_" + flowModeKey)
            }
        }
    }
    
    @Published var txtG: Double {
        didSet {
            if txtG != oldValue {
                UserDefaults.standard.set(txtG, forKey: "txtColor_G_" + flowModeKey)
            }
        }
    }
    
    @Published var txtB: Double {
        didSet {
            if txtB != oldValue {
                UserDefaults.standard.set(txtB, forKey: "txtColor_B_" + flowModeKey)
            }
        }
    }
    
    @Published var txtA: Double {
        didSet {
            if txtA != oldValue {
                UserDefaults.standard.set(txtA, forKey: "txtColor_A_" + flowModeKey)
            }
        }
    }
    
    @Published var txtRandom: Bool {
        didSet {
            if txtRandom != oldValue {
                UserDefaults.standard.set(txtRandom, forKey: "randomColor_txt_" + flowModeKey)
            }
        }
    }
    
    @Published var bgR: Double {
        didSet {
            if bgR != oldValue {
                UserDefaults.standard.set(bgR, forKey: "bgColor_R_" + flowModeKey)
            }
        }
    }
    
    @Published var bgG: Double {
        didSet {
            if bgG != oldValue {
                UserDefaults.standard.set(bgG, forKey: "bgColor_G_" + flowModeKey)
            }
        }
    }
    
    @Published var bgB: Double {
        didSet {
            if bgB != oldValue {
                UserDefaults.standard.set(bgB, forKey: "bgColor_B_" + flowModeKey)
            }
        }
    }
    
    @Published var bgA: Double {
        didSet {
            if bgA != oldValue {
                UserDefaults.standard.set(bgA, forKey: "bgColor_A_" + flowModeKey)
            }
        }
    }
    
    @Published var bgRandom: Bool {
        didSet {
            if bgRandom != oldValue {
                UserDefaults.standard.set(bgRandom, forKey: "randomColor_bg_" + flowModeKey)
            }
        }
    }
    
    @Published var interval: Double {
        didSet {
            if interval != oldValue {
                UserDefaults.standard.set(interval, forKey: "interval_" + flowModeKey)
            }
        }
    }
    
    @Published var contentType: Int {
        didSet {
            if contentType != oldValue {
                UserDefaults.standard.set(contentType, forKey: "valueType_" + flowModeKey)
            }
        }
    }
    
    @Published var number: Int {
        didSet {
            if number != oldValue {
                UserDefaults.standard.set(number, forKey: "number_" + flowModeKey)
            }
        }
    }
    
    @Published var language: Int {
        didSet {
            if language != oldValue {
                UserDefaults.standard.set(language, forKey: "language_" + flowModeKey)
            }
        }
    }
    
    @Published var symbol: Int {
        didSet {
            if symbol != oldValue {
                UserDefaults.standard.set(symbol, forKey: "symbol_" + flowModeKey)
            }
        }
    }
    
    @Published var customValue1: String? {
        didSet {
            if customValue1 != oldValue {
                UserDefaults.standard.set(customValue1, forKey: "customValue1_" + flowModeKey)
            }
        }
    }
    
    @Published var customValue2: String? {
        didSet {
            if customValue2 != oldValue {
                UserDefaults.standard.set(customValue2, forKey: "customValue2_" + flowModeKey)
            }
        }
    }
    
    @Published var isSaved: Bool {
        didSet {
            if isSaved != oldValue {
                UserDefaults.standard.set(isSaved, forKey: "saved_" + flowModeKey)
            }
        }
    }
    
    @Published var isRandomStyle: Bool {
        didSet {
            if isRandomStyle != oldValue {
                UserDefaults.standard.set(isRandomStyle, forKey: "is_random_style")
            }
        }
    }
    
    /// Initialize the properties with UserDefaults values.
    /// - Parameter flowModeKey: The flow mode's name such as "Linear" and "Fly."
    ///  Add this flowModeKey to each UserDefaults kye's trailing to identify each flow mode's UserDefaults.
    init(_ flowModeKey: String) {
        self.flowModeKey = flowModeKey
        // fonts
        fontSize = UserDefaults.standard.double(forKey: "fontSize_" + flowModeKey)
        fontSizeMin = UserDefaults.standard.double(forKey: "fontSize_min_" + flowModeKey)
        fontSizeMax = UserDefaults.standard.double(forKey: "fontSize_max_" + flowModeKey)
        fontDesign = UserDefaults.standard.integer(forKey: "fontDesign_" + flowModeKey)
        fontWeight = UserDefaults.standard.integer(forKey: "fontWeight_" + flowModeKey)
        // colors
        txtR = UserDefaults.standard.double(forKey: "txtColor_R_" + flowModeKey)
        txtG = UserDefaults.standard.double(forKey: "txtColor_G_" + flowModeKey)
        txtB = UserDefaults.standard.double(forKey: "txtColor_B_" + flowModeKey)
        txtA = UserDefaults.standard.double(forKey: "txtColor_A_" + flowModeKey)
        txtRandom = UserDefaults.standard.bool(forKey: "randomColor_txt_" + flowModeKey)
        bgR = UserDefaults.standard.double(forKey: "bgColor_R_" + flowModeKey)
        bgG = UserDefaults.standard.double(forKey: "bgColor_G_" + flowModeKey)
        bgB = UserDefaults.standard.double(forKey: "bgColor_B_" + flowModeKey)
        bgA = UserDefaults.standard.double(forKey: "bgColor_A_" + flowModeKey)
        bgRandom = UserDefaults.standard.bool(forKey: "randomColor_bg_" + flowModeKey)
        // interval of the timer
        interval = UserDefaults.standard.double(forKey: "interval_" + flowModeKey)
        // ContentType
        contentType = UserDefaults.standard.integer(forKey: "valueType_" + flowModeKey)
        number = UserDefaults.standard.integer(forKey: "number_" + flowModeKey)
        language = UserDefaults.standard.integer(forKey: "language_" + flowModeKey)
        symbol = UserDefaults.standard.integer(forKey: "symbol_" + flowModeKey)
        customValue1 = UserDefaults.standard.string(forKey: "customValue1_" + flowModeKey)
        customValue2 = UserDefaults.standard.string(forKey: "customValue2_" + flowModeKey)
        // saved or not
        isSaved = UserDefaults.standard.bool(forKey: "saved_" + flowModeKey)
        // is random style on
        isRandomStyle = UserDefaults.standard.bool(forKey: "is_random_style")
    }
    
    func saveFonts(_ fonts: Fonts) {
        self.fontSize = Double(fonts.size)
        self.fontDesign = fonts.design.rawValue
        self.fontWeight = fonts.weight.rawValue
        self.fontSizeMin = Double(fonts.sizeRange.min)
        self.fontSizeMax = Double(fonts.sizeRange.max)
    }
    
    func saveColors(_ colors: Colors) {
        self.txtR = Double(UIColor(colors.txt).rgba.red)
        self.txtG = Double(UIColor(colors.txt).rgba.green)
        self.txtB = Double(UIColor(colors.txt).rgba.blue)
        self.txtA = Double(UIColor(colors.txt).rgba.alpha)
        self.txtRandom = colors.txtRandom
        self.bgR = Double(UIColor(colors.bg).rgba.red)
        self.bgG = Double(UIColor(colors.bg).rgba.green)
        self.bgB = Double(UIColor(colors.bg).rgba.blue)
        self.bgA = Double(UIColor(colors.bg).rgba.alpha)
        self.bgRandom = colors.bgRandom
    }
    
    func saveContentTypes(_ contentTypes: Contents) {
        self.contentType = contentTypes.type.rawValue
        self.number = contentTypes.number.rawValue
        self.language = contentTypes.language.rawValue
        self.symbol = contentTypes.symbol.rawValue
        self.customValue1 = contentTypes.customValue[0]
        self.customValue2 = contentTypes.customValue[1]
    }
}
