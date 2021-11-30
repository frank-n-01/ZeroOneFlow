// Copyright © 2021 Ni Fu. All rights reserved.

import Foundation

/// Make the content of the flow for each flow mode.
class ContentMaker {
    static let numberMaker = NumberMaker()
    static let languageMaker = LanguageMaker()
    static let symbolMaker = SymbolMaker()
    
    /// Return a random content of the flow.
    ///
    /// - Parameter contents: The flow mode's contents property.
    /// - Returns: A random content.
    static func makeContent(with contents: Contents) -> String {
        
        switch contents.type {
        case .number:
            return numberMaker.makeNumber(numberType: contents.number)
        case .language:
            return languageMaker.makeLanguage(languageType: contents.language)
        case .symbol:
            return symbolMaker.makeSymbol(symbolType: contents.symbol)
        case .custom:
            return contents.customValue[Int.random(in: 0...1)]
        }
    }
    
    /// Return a linefeed randomly.
    ///
    /// - Parameter linefeed: The flow mode view's linefeed property.
    /// - Returns: A random linefeed.
    static func makeRandomLineFeed(linefeed: LineFeed) -> String {
        
        if linefeed.isOn && Int.random(in: 0...linefeed.maxLineLength) == 0 {
            return "\n"
        } else {
            return ""
        }
    }
}
