// Copyright © 2021-2022 Ni Fu. All rights reserved.

import Foundation

class SymbolMaker {
    static func make(type: SymbolType) -> String {
        switch type {
        case .box:
            return makeBox()
        case .currency:
            return makeCurrency()
        case .block:
            return makeBlock()
        case .chess:
            return makeChess()
        case .mahjong:
            return makeMahjong()
        case .kaomoji:
            return makeKaomoji()
        }
    }

    static func makeBox() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 9472...9599)))!)
    }

    static func makeCurrency() -> String {
        switch Int.random(in: 0...3) {
        case 0:
            return ContentResource.CURRENCIES.randomElement() ?? "¢"
        default:
            return String(Unicode.Scalar(UInt16(Int.random(in: 8352...8383)))!)
        }
    }

    static func makeBlock() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 9600...9631)))!)
    }

    static func makeChess() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 9812...9822)))!)
    }

    static func makeMahjong() -> String {
        switch Int.random(in: 0...10) {
        case 0:
            return String(Unicode.Scalar(UInt32(Int.random(in: 126976...126979)))!)
        default:
            return String(Unicode.Scalar(UInt32(Int.random(in: 126981...127019)))!)
        }
    }

    static func makeKaomoji() -> String {
        return ContentResource.EMOTICONS.randomElement() ?? ":)"
    }
}
