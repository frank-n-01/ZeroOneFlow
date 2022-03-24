// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class TornadoViewModel: FlowModeViewModel {
    
    var ud = TornadoUserDefaults(Mode.tornado.key)
    
    @Published var scale: Double {
        didSet {
            ud.scale = scale
        }
    }
    
    @Published var durationRange: Range {
        didSet {
            durationRange.save(min: &ud.durationMin, max: &ud.durationMax)
        }
    }
    
    @Published var angleRange: Range {
        didSet {
            angleRange.save(min: &ud.angleMin, max: &ud.angleMax)
        }
    }
    
    init() {
        scale = TornadoDefault.SCALE
        durationRange = TornadoDefault.DURATION
        angleRange = TornadoDefault.ANGLE
        super.init(ud: ud, fonts: TornadoDefault.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        fonts.sizeRange.random(max: 150)
        scale = Double.random(in: 1...200)
        angleRange.random(max: 100)
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            scale = ud.scale > 0 ? ud.scale : TornadoDefault.SCALE
            durationRange.set(min: ud.durationMin, max: ud.durationMax)
            angleRange.set(min: ud.angleMin, max: ud.angleMax)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = scale
        durationRange.save(min: &ud.durationMin, max: &ud.durationMax)
        angleRange.save(min: &ud.angleMin, max: &ud.angleMax)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        scale = TornadoDefault.SCALE
        fonts = TornadoDefault.FONT
        durationRange = TornadoDefault.DURATION
        angleRange = TornadoDefault.ANGLE
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Tornado else { return }
        
        scale = style.scale
        fonts.sizeRange.set(min: CGFloat(style.fontSizeMin),
                            max: CGFloat(style.fontSizeMax))
        durationRange.set(min: style.durationMin, max: style.durationMax)
        angleRange.set(min: style.angleMin, max: style.angleMax)
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Tornado(context: context)
        style.scale = scale
        fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
        durationRange.save(min: &style.durationMin, max: &style.durationMax)
        angleRange.save(min: &style.angleMin, max: &style.angleMax)
       
        super.saveCoreData(context, name, style)
    }
}

private class TornadoDefault {
    static let FONT = Fonts(size: 0, design: .random,
                            weight: .random, min: 5, max: 50)
    static let SCALE = 15.0
    static let DURATION = Range(min: 0.01, max: 3.0)
    static let ANGLE = Range(min: 1, max: 30)
}
