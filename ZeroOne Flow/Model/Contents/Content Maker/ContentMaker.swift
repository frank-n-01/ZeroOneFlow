// Copyright © 2021 Ni Fu. All rights reserved.

import Foundation

/// Make the content of the flow for each flow mode.
class ContentMaker {
    
    /// Return a random content of the flow.
    ///
    /// - Parameter contents: The flow mode's contents property.
    /// - Returns: A random content.
    static func make(with contents: Contents) -> String {
        
        switch contents.type {
        case .number:
            return NumberMaker.make(type: contents.number)
        case .language:
            return LanguageMaker.make(type: contents.language)
        case .symbol:
            return SymbolMaker.make(type: contents.symbol)
        case .custom:
            return contents.customValue[Int.random(in: 0...1)]
        case .code:
            return CodeMaker.make(type: contents.code)
        }
    }
    
    /// If the line feed is off, indents will not be added.
    static func getRandomLineFeed(_ linefeed: TextFormat, _ indents: TextFormat,
                                  _ contents: Contents) -> String {
        guard linefeed.isOn else {
            return ""
        }
        guard Int.random(in: 0...Int(linefeed.value)) == 0 else {
            return ""
        }
        // BASIC does not need indents.
        if contents.type == .code && contents.code == .basic {
            return "\n" + getRandomIndent(indents) + CodeMaker.getLineNumber()
        }
        return "\n" + getRandomIndent(indents)
    }
    
    static func getRandomIndent(_ indents: TextFormat) -> String {
        guard indents.isOn else {
            return ""
        }
        var indent = ""
        for _ in 0...Int.random(in: 0...Int(indents.value)) {
            indent += "\t"
        }
        return indent
    }
    
    /// Reset the status of content makers.
    static func reset() {
        CodeMaker.reset()
    }
}
