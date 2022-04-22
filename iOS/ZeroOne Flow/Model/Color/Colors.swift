// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct Colors: Equatable {
    var txt: Color
    var txtRandom: Bool
    var bg: Color
    var bgRandom: Bool
        
    init() {
        self.txt = CommonStyle.TEXT_COLOR
        self.txtRandom = false
        self.bg = CommonStyle.BACKGROUND_COLOR
        self.bgRandom = false
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
        self.txt = Color(red: txtR, green: txtG, blue: txtB, opacity: txtA)
        self.bg = Color(red: bgR, green: bgG, blue: bgB, opacity: bgA)
        self.txtRandom = txtRandom
        self.bgRandom = bgRandom
    }
    
    nonmutating func save(txtR: inout Double, txtG: inout Double,
                          txtB: inout Double, txtA: inout Double,
                          bgR: inout Double, bgG: inout Double,
                          bgB: inout Double, bgA: inout Double) {
        txtR = Double(UIColor(self.txt).rgba.red)
        txtG = Double(UIColor(self.txt).rgba.green)
        txtB = Double(UIColor(self.txt).rgba.blue)
        txtA = Double(UIColor(self.txt).rgba.alpha)
        bgR = Double(UIColor(self.bg).rgba.red)
        bgG = Double(UIColor(self.bg).rgba.green)
        bgB = Double(UIColor(self.bg).rgba.blue)
        bgA = Double(UIColor(self.bg).rgba.alpha)
    }
    
    nonmutating func save(txtR: inout Double, txtG: inout Double, txtB: inout Double,
                          txtA: inout Double, txtRandom: inout Bool,
                          bgR: inout Double, bgG: inout Double, bgB: inout Double,
                          bgA: inout Double, bgRandom: inout Bool) {
        self.save(txtR: &txtR, txtG: &txtG, txtB: &txtB, txtA: &txtA,
                  bgR: &bgR, bgG: &bgG, bgB: &bgB, bgA: &bgA)
        txtRandom = self.txtRandom
        bgRandom = self.bgRandom
    }
    
    mutating func reset() {
        self.txt = CommonStyle.TEXT_COLOR
        self.txtRandom = false
        self.bg = CommonStyle.BACKGROUND_COLOR
        self.bgRandom = false
    }
    
    mutating func random() {
        self.txt = Colors.random()
        self.bg = Colors.random()
    }
    
    mutating func randomOnCondition() {
        if txtRandom {
            self.txt = Colors.random()
        }
        
        if bgRandom {
            self.bg = Colors.random()
        }
    }
    
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1.0),
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
