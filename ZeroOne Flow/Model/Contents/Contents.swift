// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Define the content of the flow.
struct Contents: Equatable, Identifiable {
    var type: ContentType
    var number: NumberType
    var language: LanguageType
    var symbol: SymbolType
    var customValue: [String]
    var code: CodeType
    
    var id: UUID { return UUID() }
    
    static let TYPE: ContentType = .number
    static let NUMBER: NumberType = .binary
    static let LANGUAGE: LanguageType = .hieroglyph
    static let SYMBOL: SymbolType = .block
    static let CUSTOM = ["Fizz", "Buzz"]
    static let CODE: CodeType = .cobol
    
    init() {
        self.type = Self.TYPE
        self.number = Self.NUMBER
        self.language = Self.LANGUAGE
        self.symbol = Self.SYMBOL
        self.customValue = Self.CUSTOM
        self.code = Self.CODE
    }
    
    mutating func set(type: ContentType, number: NumberType,
                      language: LanguageType, symbol: SymbolType,
                      customValue1: String, customValue2: String, code: CodeType) {
        self.type = type
        self.number = number
        self.language = language
        self.symbol = symbol
        self.customValue[0] = customValue1
        self.customValue[1] = customValue2
        self.code = code
    }
    
    mutating func set(type: Int, number: Int, language: Int, symbol: Int,
                      customValue1: String, customValue2: String, code: Int) {
        self.type = ContentType(rawValue: type) ?? Self.TYPE
        self.number = NumberType(rawValue: number) ?? Self.NUMBER
        self.language = LanguageType(rawValue: language) ?? Self.LANGUAGE
        self.symbol = SymbolType(rawValue: symbol) ?? Self.SYMBOL
        self.customValue[0] = customValue1
        self.customValue[1] = customValue2
        self.code = CodeType(rawValue: code) ?? Self.CODE
    }
    
    func save(type: inout Int, number: inout Int,
              language: inout Int, symbol: inout Int, custom1: inout String?,
              custom2: inout String?, code: inout Int) {
        type = self.type.rawValue
        number = self.number.rawValue
        language = self.language.rawValue
        symbol = self.symbol.rawValue
        custom1 = self.customValue[0]
        custom2 = self.customValue[1]
        code = self.code.rawValue
    }
    
    func save(type: inout Int16, number: inout Int16,
              language: inout Int16, symbol: inout Int16,
              custom1: inout String?, custom2: inout String?, code: inout Int16) {
        type = Int16(self.type.rawValue)
        number = Int16(self.number.rawValue)
        language = Int16(self.language.rawValue)
        symbol = Int16(self.symbol.rawValue)
        custom1 = self.customValue[0]
        custom2 = self.customValue[1]
        code = Int16(self.code.rawValue)
    }
    
    mutating func reset() {
        self.type = Self.TYPE
        self.number = Self.NUMBER
        self.language = Self.LANGUAGE
        self.symbol = Self.SYMBOL
        self.customValue = Self.CUSTOM
        self.code = Self.CODE
    }
    
    mutating func random() {
        self.type = ContentType.allCasesWithoutCustom.randomElement() ?? Self.TYPE
        self.number = NumberType.allCases.randomElement() ?? Self.NUMBER
        self.language = LanguageType.allCases.randomElement() ?? Self.LANGUAGE
        self.symbol = SymbolType.allCases.randomElement() ?? Self.SYMBOL
        self.code = CodeType.allCases.randomElement() ?? Self.CODE
    }
}
