// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct Colors: Equatable {
    var txt: Color
    var txtRandom: Bool
    var bg: Color
    var bgRandom: Bool
        
    init() {
        txt = CommonStyle.TEXT_COLOR
        txtRandom = false
        bg = CommonStyle.BACKGROUND_COLOR
        bgRandom = false
    }
    
    static func == (lhs: Colors, rhs: Colors) -> Bool {
        return lhs.txt.description == rhs.txt.description
            && lhs.txtRandom == rhs.txtRandom
            && lhs.bg.description == rhs.bg.description
            && lhs.bgRandom == rhs.bgRandom
    }
        
    mutating func set(txtR: Double, txtG: Double, txtB: Double, txtA: Double,
                      txtRandom: Bool = false, bgR: Double, bgG: Double,
                      bgB: Double, bgA: Double, bgRandom: Bool = false) {
        txt = Color(red: txtR, green: txtG, blue: txtB, opacity: txtA)
        bg = Color(red: bgR, green: bgG, blue: bgB, opacity: bgA)
        self.txtRandom = txtRandom
        self.bgRandom = bgRandom
    }
    
    nonmutating func save(txtR: inout Double, txtG: inout Double,
                          txtB: inout Double, txtA: inout Double,
                          bgR: inout Double, bgG: inout Double,
                          bgB: inout Double, bgA: inout Double) {
        txtR = Double(UIColor(txt).rgba.red)
        txtG = Double(UIColor(txt).rgba.green)
        txtB = Double(UIColor(txt).rgba.blue)
        txtA = Double(UIColor(txt).rgba.alpha)
        bgR = Double(UIColor(bg).rgba.red)
        bgG = Double(UIColor(bg).rgba.green)
        bgB = Double(UIColor(bg).rgba.blue)
        bgA = Double(UIColor(bg).rgba.alpha)
    }
    
    nonmutating func save(txtR: inout Double, txtG: inout Double, txtB: inout Double,
                          txtA: inout Double, txtRandom: inout Bool,
                          bgR: inout Double, bgG: inout Double, bgB: inout Double,
                          bgA: inout Double, bgRandom: inout Bool) {
        save(txtR: &txtR, txtG: &txtG, txtB: &txtB, txtA: &txtA,
             bgR: &bgR, bgG: &bgG, bgB: &bgB, bgA: &bgA)
        txtRandom = self.txtRandom
        bgRandom = self.bgRandom
    }
    
    mutating func reset() {
        txt = CommonStyle.TEXT_COLOR
        txtRandom = false
        bg = CommonStyle.BACKGROUND_COLOR
        bgRandom = false
    }
    
    mutating func random() {
        txt = Self.random()
        bg = Self.random()
    }
    
    mutating func randomOnCondition() {
        if txtRandom {
            txt = Self.random()
        }
        
        if bgRandom {
            bg = Self.random()
        }
    }
    
    static func random() -> Color {
        Color(red: Double.random(in: 0...1.0),
              green: Double.random(in: 0...1.0),
              blue: Double.random(in: 0...1.0),
              opacity: Double.random(in: 0.6...1.0))
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
