// Copyright © 2021 Ni Fu. All rights reserved.

import Foundation

class LanguageMaker {
    
    static func make(type: LanguageType) -> String {
        var language = ""
        
        switch type {
        case .latin:
            return makeLatin()
        case .cuneiform:
            return makeCuneiform()
        case .greek:
            return makeGreek()
        case .hieroglyph:
            return makeHieroglyph()
        case .arabic:
            return makeArabic()
        case .devanagari:
            return makeDevanagari()
        case .chinese:
            return makeChinese()
        case .english:
            language = makeEnglish()
        case .japanese:
            return makeJapanese()
        case .spanish:
            language = makeSpanish()
        }
        
        if ModeUserDefaults.currentMode == Mode.linear.rawValue {
            language += " "
        }
        return language
    }

    static func makeLatin() -> String {
        switch Int.random(in: 0...3) {
        case 0:
            return String(Unicode.Scalar(UInt16(Int.random(in: 65...90)))!)
        case 1:
            return String(Unicode.Scalar(UInt16(Int.random(in: 97...122)))!)
        default:
            return String(Unicode.Scalar(UInt16(Int.random(in: 256...382)))!)
        }
    }

    static func makeCuneiform() -> String {
        switch Int.random(in: 0...7) {
        case 0..<6:
            return String(Unicode.Scalar(UInt32(Int.random(in: 73728...74649)))!)
        case 6:
            return String(Unicode.Scalar(UInt32(Int.random(in: 74752...74862)))!)
        default:
            return String(Unicode.Scalar(UInt32(Int.random(in: 74880...75075)))!)
        }
    }

    static func makeGreek() -> String {
        switch Int.random(in: 0...4) {
        case 0:
            return String(Unicode.Scalar(UInt16(Int.random(in: 913...929)))!)
        default:
            return String(Unicode.Scalar(UInt16(Int.random(in: 945...969)))!)
        }
    }

    static func makeHieroglyph() -> String {
        return String(Unicode.Scalar(UInt32(Int.random(in: 77824...78894)))!)
    }

    static func makeArabic() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 1566...1749)))!)
    }

    static func makeDevanagari() -> String {
        switch Int.random(in: 0...4) {
        case 0..<3:
            return String(Unicode.Scalar(UInt16(Int.random(in: 2308...2361)))!)
        case 3:
            return String(Unicode.Scalar(UInt16(Int.random(in: 2392...2401)))!)
        default:
            return String(Unicode.Scalar(UInt16(Int.random(in: 2418...2431)))!)
        }
    }

    static func makeChinese() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 19968...40879)))!)
    }
    
    static func makeEnglish() -> String {
        return ContentResource.ENGLISH.randomElement() ?? ""
    }
    
    static func makeJapanese() -> String {
        return ContentResource.JAPANESE.randomElement() ?? ""
    }
    
    static func makeSpanish() -> String {
        return ContentResource.SPANISH.randomElement() ?? ""
    }
}
