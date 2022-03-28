// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

class FlowModeUserDefaults: ObservableObject {
    
    @Published var flowMode: String
    
    @Published var isInitialized: Bool {
        didSet {
            if isInitialized != oldValue {
                UserDefaults.standard
                    .set(isInitialized,
                         forKey: Keys.isInitialized.rawValue + flowMode)
            }
        }
    }
    
    @Published var fontSize: Double {
        didSet {
            if fontSize != oldValue {
                UserDefaults.standard
                    .set(fontSize, forKey: Keys.fontSize.rawValue + flowMode)
            }
        }
    }
    
    @Published var fontSizeMin: Double {
        didSet {
            if fontSizeMin != oldValue {
                UserDefaults.standard
                    .set(fontSizeMin, forKey: Keys.fontSizeMin.rawValue + flowMode)
            }
        }
    }
    
    @Published var fontSizeMax: Double {
        didSet {
            if fontSizeMax != oldValue {
                UserDefaults.standard
                    .set(fontSizeMax, forKey: Keys.fontSizeMax.rawValue + flowMode)
            }
        }
    }
    
    @Published var fontDesign: Int {
        didSet {
            if fontDesign != oldValue {
                UserDefaults.standard
                    .set(fontDesign, forKey: Keys.fontDesign.rawValue + flowMode)
            }
        }
    }
    
    @Published var fontWeight: Int {
        didSet {
            if fontWeight != oldValue {
                UserDefaults.standard
                    .set(fontWeight, forKey: Keys.fontWeight.rawValue + flowMode)
            }
        }
    }
    
    @Published var txtR: Double {
        didSet {
            if txtR != oldValue {
                UserDefaults.standard
                    .set(txtR, forKey: Keys.txtR.rawValue + flowMode)
            }
        }
    }
    
    @Published var txtG: Double {
        didSet {
            if txtG != oldValue {
                UserDefaults.standard
                    .set(txtG, forKey: Keys.txtG.rawValue + flowMode)
            }
        }
    }
    
    @Published var txtB: Double {
        didSet {
            if txtB != oldValue {
                UserDefaults.standard
                    .set(txtB, forKey: Keys.txtB.rawValue + flowMode)
            }
        }
    }
    
    @Published var txtA: Double {
        didSet {
            if txtA != oldValue {
                UserDefaults.standard
                    .set(txtA, forKey: Keys.txtA.rawValue + flowMode)
            }
        }
    }
    
    @Published var txtRandom: Bool {
        didSet {
            if txtRandom != oldValue {
                UserDefaults.standard
                    .set(txtRandom, forKey: Keys.txtRandomColor.rawValue + flowMode)
            }
        }
    }
    
    @Published var bgR: Double {
        didSet {
            if bgR != oldValue {
                UserDefaults.standard
                    .set(bgR, forKey: Keys.bgR.rawValue + flowMode)
            }
        }
    }
    
    @Published var bgG: Double {
        didSet {
            if bgG != oldValue {
                UserDefaults.standard
                    .set(bgG, forKey: Keys.bgG.rawValue + flowMode)
            }
        }
    }
    
    @Published var bgB: Double {
        didSet {
            if bgB != oldValue {
                UserDefaults.standard
                    .set(bgB, forKey: Keys.bgB.rawValue + flowMode)
            }
        }
    }
    
    @Published var bgA: Double {
        didSet {
            if bgA != oldValue {
                UserDefaults.standard
                    .set(bgA, forKey: Keys.bgA.rawValue + flowMode)
            }
        }
    }
    
    @Published var bgRandom: Bool {
        didSet {
            if bgRandom != oldValue {
                UserDefaults.standard
                    .set(bgRandom, forKey: Keys.bgRandomColor.rawValue + flowMode)
            }
        }
    }
    
    @Published var interval: Double {
        didSet {
            if interval != oldValue {
                UserDefaults.standard
                    .set(interval, forKey: Keys.interval.rawValue + flowMode)
            }
        }
    }
    
    @Published var contentType: Int {
        didSet {
            if contentType != oldValue {
                UserDefaults.standard
                    .set(contentType, forKey: Keys.contentType.rawValue + flowMode)
            }
        }
    }
    
    @Published var number: Int {
        didSet {
            if number != oldValue {
                UserDefaults.standard
                    .set(number, forKey: Keys.number.rawValue + flowMode)
            }
        }
    }
    
    @Published var language: Int {
        didSet {
            if language != oldValue {
                UserDefaults.standard
                    .set(language, forKey: Keys.language.rawValue + flowMode)
            }
        }
    }
    
    @Published var symbol: Int {
        didSet {
            if symbol != oldValue {
                UserDefaults.standard
                    .set(symbol, forKey: Keys.symbol.rawValue + flowMode)
            }
        }
    }
    
    @Published var customValue1: String? {
        didSet {
            if customValue1 != oldValue {
                UserDefaults.standard
                    .set(customValue1, forKey: Keys.customValue1.rawValue + flowMode)
            }
        }
    }
    
    @Published var customValue2: String? {
        didSet {
            if customValue2 != oldValue {
                UserDefaults.standard
                    .set(customValue2, forKey: Keys.customValue2.rawValue + flowMode)
            }
        }
    }
    
    @Published var code: Int {
        didSet {
            if code != oldValue {
                UserDefaults.standard
                    .set(code, forKey: Keys.code.rawValue + flowMode)
            }
        }
    }
    
    init(_ flowMode: String) {
        self.flowMode = flowMode
        
        isInitialized = UserDefaults.standard
            .bool(forKey: Keys.isInitialized.rawValue + flowMode)
        
        fontSize = UserDefaults.standard
            .double(forKey: Keys.fontSize.rawValue + flowMode)
        fontSizeMin = UserDefaults.standard
            .double(forKey: Keys.fontSizeMin.rawValue + flowMode)
        fontSizeMax = UserDefaults.standard
            .double(forKey: Keys.fontSizeMax.rawValue + flowMode)
        fontDesign = UserDefaults.standard
            .integer(forKey: Keys.fontDesign.rawValue + flowMode)
        fontWeight = UserDefaults.standard
            .integer(forKey: Keys.fontWeight.rawValue + flowMode)
        
        txtR = UserDefaults.standard.double(forKey: Keys.txtR.rawValue + flowMode)
        txtG = UserDefaults.standard.double(forKey: Keys.txtG.rawValue + flowMode)
        txtB = UserDefaults.standard.double(forKey: Keys.txtB.rawValue + flowMode)
        txtA = UserDefaults.standard.double(forKey: Keys.txtA.rawValue + flowMode)
        txtRandom = UserDefaults.standard
            .bool(forKey: Keys.txtRandomColor.rawValue + flowMode)
        
        bgR = UserDefaults.standard.double(forKey: Keys.bgR.rawValue + flowMode)
        bgG = UserDefaults.standard.double(forKey: Keys.bgG.rawValue + flowMode)
        bgB = UserDefaults.standard.double(forKey: Keys.bgB.rawValue + flowMode)
        bgA = UserDefaults.standard.double(forKey: Keys.bgA.rawValue + flowMode)
        bgRandom = UserDefaults.standard
            .bool(forKey: Keys.bgRandomColor.rawValue + flowMode)
        
        interval = UserDefaults.standard
            .double(forKey: Keys.interval.rawValue + flowMode)
        
        contentType = UserDefaults.standard
            .integer(forKey: Keys.contentType.rawValue + flowMode)
        number = UserDefaults.standard
            .integer(forKey: Keys.number.rawValue + flowMode)
        language = UserDefaults.standard
            .integer(forKey: Keys.language.rawValue + flowMode)
        symbol = UserDefaults.standard
            .integer(forKey: Keys.symbol.rawValue + flowMode)
        customValue1 = UserDefaults.standard
            .string(forKey: Keys.customValue1.rawValue + flowMode)
        customValue2 = UserDefaults.standard
            .string(forKey: Keys.customValue2.rawValue + flowMode)
        code = UserDefaults.standard
            .integer(forKey: Keys.code.rawValue + flowMode)
    }
    
    func saveFonts(_ fonts: Fonts) {
        fontSize = Double(fonts.size)
        fontDesign = fonts.design.rawValue
        fontWeight = fonts.weight.rawValue
        fontSizeMin = Double(fonts.sizeRange.min)
        fontSizeMax = Double(fonts.sizeRange.max)
    }
    
    func saveColors(_ colors: Colors) {
        txtR = Double(UIColor(colors.txt).rgba.red)
        txtG = Double(UIColor(colors.txt).rgba.green)
        txtB = Double(UIColor(colors.txt).rgba.blue)
        txtA = Double(UIColor(colors.txt).rgba.alpha)
        txtRandom = colors.txtRandom
        
        bgR = Double(UIColor(colors.bg).rgba.red)
        bgG = Double(UIColor(colors.bg).rgba.green)
        bgB = Double(UIColor(colors.bg).rgba.blue)
        bgA = Double(UIColor(colors.bg).rgba.alpha)
        bgRandom = colors.bgRandom
    }
    
    func saveContents(_ contents: Contents) {
        contentType = contents.type.rawValue
        number = contents.number.rawValue
        language = contents.language.rawValue
        symbol = contents.symbol.rawValue
        customValue1 = contents.customValue[0]
        customValue2 = contents.customValue[1]
        code = contents.code.rawValue
    }
    
    private enum Keys: String {
        case isInitialized = "saved_"
        case fontSize = "fontSize_"
        case fontSizeMin = "fontSize_min_"
        case fontSizeMax = "fontSize_max_"
        case fontDesign = "fontDesign_"
        case fontWeight = "fontWeight_"
        case txtR = "txtColor_R_"
        case txtG = "txtColor_G_"
        case txtB = "txtColor_B_"
        case txtA = "txtColor_A_"
        case txtRandomColor = "randomColor_txt_"
        case bgR = "bgColor_R_"
        case bgG = "bgColor_G_"
        case bgB = "bgColor_B_"
        case bgA = "bgColor_A_"
        case bgRandomColor = "randomColor_bg_"
        case interval = "interval_"
        case contentType = "valueType_"
        case number = "number_"
        case language = "language_"
        case symbol = "symbol_"
        case customValue1 = "customValue1_"
        case customValue2 = "customValue2_"
        case code = "code_"
    }
}
