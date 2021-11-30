// Copyright © 2021 Ni Fu. All rights reserved.

import Foundation

class SymbolMaker {
    
    let resource = ContentResource()
    
    func makeSymbol(symbolType: SymbolType) -> String {
        switch symbolType {
        case .box:
            return makeBox()
        case .money:
            return makeMoney()
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

    func makeBox() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 9472...9599)))!)
    }

    func makeMoney() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 8352...8383)))!)
    }

    func makeBlock() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 9600...9631)))!)
    }

    func makeChess() -> String {
        return String(Unicode.Scalar(UInt16(Int.random(in: 9812...9822)))!)
    }

    func makeMahjong() -> String {
        switch Int.random(in: 0...10) {
        case 0:
            return String(Unicode.Scalar(UInt32(Int.random(in: 126976...126979)))!)
        default:
            return String(Unicode.Scalar(UInt32(Int.random(in: 126981...127019)))!)
        }
    }

    func makeKaomoji() -> String {
        guard let kaomoji = resource.emoticons.randomElement() else { return "" }
        return kaomoji
    }
}
