//  Copyright © 2021 Ni Fu. All rights reserved.

import Foundation

class CodeMaker {
    
    /// The line number of BASIC.
    static var lineNumber = 0
    
    /// If the line number is equal to this first value, that is the first line of the flow.
    static var firstLineNumber = 0
    
    /// Operators and symbols may not be appear continuously.
    static var isAfterKeyWord = false
        
    static func make(type: CodeType) -> String {
        var code = ""
        switch type {
        case .cobol:
            code += makeCOBOL()
        case .basic:
            code += makeBASIC()
        case .c:
            code += makeC()
        case .sql:
            code += makeSQL()
        case .html:
            code += makeHTML()
        }
        // In Linear mode, a space is necessary after each word.
        if ModeUserDefaults.currentMode == Mode.linear.rawValue {
            code += " "
        }
        return code
    }
    
    static func makeCOBOL() -> String {
        return ContentResource.COBOL.randomElement() ?? "COBOL"
    }
    
    static func makeBASIC() -> String {
        var basic = ContentResource.BASIC.randomElement() ?? "BASIC"
        
        if basic == "GOTO" {
            basic += " \(Int.random(in: 1...99) * 10)"
        }
        // Add the first line number.
        if lineNumber == firstLineNumber {
            basic = getLineNumber() + basic
        }
        return basic
    }
    
    static func makeC() -> String {
        var c = ""
        if Int.random(in: 0...2) == 0 && isAfterKeyWord {
            c += ContentResource.OPERATORS_C.randomElement() ?? ";"
            isAfterKeyWord = false
        } else {
            c += ContentResource.C.randomElement() ?? "C"
            if Int.random(in: 0...7) == 0 {
                c += ";"
                isAfterKeyWord = false
                return c
            }
            if !isAfterKeyWord {
                isAfterKeyWord = true
            }
        }
        return c
    }
    
    static func makeSQL() -> String {
        var sql = ""
        if Int.random(in: 0...5) == 0 && isAfterKeyWord {
            sql += ContentResource.OPERATORS_SQL.randomElement() ?? ";"
            isAfterKeyWord = false
        } else {
            sql += ContentResource.SQL.randomElement() ?? "SQL"
            if Int.random(in: 0...7) == 0 {
                sql += ";"
                isAfterKeyWord = false
                return sql
            }
            if !isAfterKeyWord {
                isAfterKeyWord = true
            }
        }
        return sql
    }
    
    static func makeHTML() -> String {
        var tag = "<"
        
        if Int.random(in: 0...2) == 0 {
            tag += "/"
        }
        tag += ContentResource.HTML.randomElement() ?? "HTML"
        tag += ">"
        
        return tag
    }
    
    static func getLineNumber() -> String {
        lineNumber += Int.random(in: 1...5) * 10
        return "\(lineNumber) "
    }
    
    static func reset() {
        lineNumber = Int.random(in: 0...10) * 10
        firstLineNumber = lineNumber
        isAfterKeyWord = false
    }
}
