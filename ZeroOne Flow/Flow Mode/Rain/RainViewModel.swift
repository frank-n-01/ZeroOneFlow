// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class RainViewModel: FlowModeViewModel {
    
    var ud = RainUserDefaults(Mode.rain.key)
    
    @Published var scale: Double {
        didSet {
            ud.scale = scale
        }
    }
    
    @Published var interval: Double {
        didSet {
            ud.interval = interval
        }
    }

    @Published var length: Double {
        didSet {
            ud.length = length
        }
    }
    
    @Published var step: Double {
        didSet {
            ud.step = step
        }
    }
    
    let SCALE = 100.0
    let INTERVAL = 0.05
    let LENGTH = 200.0
    let STEP = 200.0
    let FONT = Fonts(size: 0, design: .random, weight: .ultraLight, min: 15, max: 50)
    
    init() {
        scale = SCALE
        interval = INTERVAL
        length = LENGTH
        step = STEP
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            scale = Double.random(in: 1...200)
            interval = Double.random(in: 0.01...0.05)
            fonts.sizeRange.random(max: 100)
            length = Double.random(in: 50...300)
            step = CGFloat.random(in: 100...500)
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            scale = ud.scale > 0 ? ud.scale : SCALE
            interval = ud.interval > 0 ? ud.interval : INTERVAL
            length = ud.length > 0 ? ud.length : LENGTH
            step = ud.step > 0 ? ud.step : STEP
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = scale
        ud.interval = interval
        ud.length = length
        ud.step = step
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        fonts = FONT
        scale = SCALE
        interval = INTERVAL
        length = LENGTH
        step = STEP
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Rain else { return }
        
        fonts.sizeRange.set(min: CGFloat(style.fontSizeMin), max: CGFloat(style.fontSizeMax))
        scale = style.scale > 0 ? style.scale : SCALE
        interval = style.interval > 0 ? style.interval : INTERVAL
        length = style.length > 0 ? style.length : LENGTH
        step = style.step > 0 ? style.step : STEP
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Rain(context: context)
        fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
        style.scale = scale
        style.interval = interval
        style.length = length
        style.step = step
        
        super.saveCoreData(context, name, style)
    }
}
