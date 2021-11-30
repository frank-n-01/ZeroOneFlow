// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class TornadoViewModel: FlowModeViewModel {
    
    var ud = TornadoUserDefaults(Mode.tornado.key)
    
    @Published var scale: Double {
        didSet {
            ud.scale = self.scale
        }
    }
    
    @Published var durationRange: Range {
        didSet {
            self.durationRange.save(min: &ud.durationMin, max: &ud.durationMax)
        }
    }
    
    @Published var angleRange: Range {
        didSet {
            self.angleRange.save(min: &ud.angleMin, max: &ud.angleMax)
        }
    }
    
    let SCALE = 15.0
    let DURATION = Range(min: 0.01, max: 3.0)
    let ANGLE = Range(min: 1, max: 30)
    let FONT = Fonts(size: 0, design: .random, weight: .random, min: 5, max: 50)
    
    init() {
        self.scale = SCALE
        self.durationRange = DURATION
        self.angleRange = ANGLE
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            self.fonts.sizeRange.random(max: 150)
            self.scale = Double.random(in: 1...200)
            self.angleRange.random(max: 100)
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            self.scale = ud.scale > 0 ? ud.scale : SCALE
            self.durationRange.set(min: ud.durationMin, max: ud.durationMax)
            self.angleRange.set(min: ud.angleMin, max: ud.angleMax)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = self.scale
        self.durationRange.save(min: &ud.durationMin, max: &ud.durationMax)
        self.angleRange.save(min: &ud.angleMin, max: &ud.angleMax)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        self.scale = SCALE
        self.fonts = FONT
        self.durationRange = DURATION
        self.angleRange = ANGLE
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Tornado else { return }
        self.scale = style.scale
        self.fonts.sizeRange.set(min: CGFloat(style.fontSizeMin), max: CGFloat(style.fontSizeMax))
        self.durationRange.set(min: style.durationMin, max: style.durationMax)
        self.angleRange.set(min: style.angleMin, max: style.angleMax)
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Tornado(context: context)
        style.scale = self.scale
        self.fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
        self.durationRange.save(min: &style.durationMin, max: &style.durationMax)
        self.angleRange.save(min: &style.angleMin, max: &style.angleMax)
       
        super.saveCoreData(context, name, style)
    }
}
