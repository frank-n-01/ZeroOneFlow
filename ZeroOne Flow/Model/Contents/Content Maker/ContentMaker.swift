// Copyright © 2021-2022 Ni Fu. All rights reserved.

import Foundation

class ContentMaker {
    static func make(with contents: Contents) -> String {
        switch contents.type {
        case .number:
            return NumberMaker.make(type: contents.number)
        case .language:
            return LanguageMaker.make(type: contents.language)
        case .symbol:
            return SymbolMaker.make(type: contents.symbol)
        case .custom:
            return contents.customValue.randomElement() ?? ""
        case .code:
            return CodeMaker.make(type: contents.code)
        }
    }
    
    static func getRandomLineFeed(_ linefeed: TextFormat, _ indents: TextFormat,
                                  _ contents: Contents) -> String {
        guard linefeed.isOn else { return "" }
        guard Int.random(in: 0...Int(linefeed.value)) == 0 else { return "" }
        
        // BASIC does not need indents.
        if contents.type == .code && contents.code == .basic {
            return "\n" + CodeMaker.getLineNumber()
        }
        return "\n" + getRandomIndent(indents)
    }
    
    static func getRandomIndent(_ indents: TextFormat) -> String {
        guard indents.isOn else { return "" }
        
        var indent = ""
        for _ in 0...Int.random(in: 0...Int(indents.value)) {
            indent += "\t"
        }
        return indent
    }
    
    static func reset() {
        CodeMaker.reset()
    }
}
