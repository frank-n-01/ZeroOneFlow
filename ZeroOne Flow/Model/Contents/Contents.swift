// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

/// Define the content of the flow.
struct Contents: Equatable, Identifiable {
    var type: ContentType
    var number: NumberType
    var language: LanguageType
    var symbol: SymbolType
    var customValue: [String]
    
    var id: UUID { return UUID() }
    
    init() {
        self.type = .number
        self.number = .binary
        self.language = .hieroglyph
        self.symbol = .block
        self.customValue = ["Fizz", "Buzz"]
    }
    
    mutating func set(type: ContentType, number: NumberType, language: LanguageType, symbol: SymbolType, customValue1: String, customValue2: String) {
        self.type = type
        self.number = number
        self.language = language
        self.symbol = symbol
        self.customValue[0] = customValue1
        self.customValue[1] = customValue2
    }
    
    mutating func set(type: Int, number: Int, language: Int, symbol: Int, customValue1: String, customValue2: String) {
        self.type = ContentType(rawValue: type) ?? .number
        self.number = NumberType(rawValue: number) ?? .binary
        self.language = LanguageType(rawValue: language) ?? .hieroglyph
        self.symbol = SymbolType(rawValue: symbol) ?? .block
        self.customValue[0] = customValue1
        self.customValue[1] = customValue2
    }
    
    func save(type: inout Int, number: inout Int, language: inout Int, symbol: inout Int, custom1: inout String?, custom2: inout String?) {
        type = self.type.rawValue
        number = self.number.rawValue
        language = self.language.rawValue
        symbol = self.symbol.rawValue
        custom1 = self.customValue[0]
        custom2 = self.customValue[1]
    }
    
    func save(type: inout Int16, number: inout Int16, language: inout Int16, symbol: inout Int16, custom1: inout String?, custom2: inout String?) {
        type = Int16(self.type.rawValue)
        number = Int16(self.number.rawValue)
        language = Int16(self.language.rawValue)
        symbol = Int16(self.symbol.rawValue)
        custom1 = self.customValue[0]
        custom2 = self.customValue[1]
    }
    
    mutating func reset() {
        self.type = .number
        self.number = .binary
        self.language = .hieroglyph
        self.symbol = .block
        self.customValue = ["Fizz", "Buzz"]
    }
    
    mutating func random() {
        let types = ContentType.allCases
        self.type = types[Int.random(in: 0 ..< types.count - 1)] // remove "Custom"
        self.number = NumberType.allCases.randomElement() ?? .binary
        self.language = LanguageType.allCases.randomElement() ?? .hieroglyph
        self.symbol = SymbolType.allCases.randomElement() ?? .block
    }
}
