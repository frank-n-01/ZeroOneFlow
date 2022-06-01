// Copyright © 2021-2022 Ni Fu. All rights reserved.

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
    
    static let FONT = Fonts(size: 0, design: .random,
                            weight: .ultraLight, min: 10, max: 40)
    static let SCALE = 100.0
    static let INTERVAL = 0.05
    static let LENGTH = 150.0
    static let STEP = 200.0
    
    init() {
        scale = Self.SCALE
        interval = Self.INTERVAL
        length = Self.LENGTH
        step = Self.STEP
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        scale = Double.random(in: 1...120)
        interval = Double.random(in: 0.02...0.08)
        fonts.sizeRange.random(max: 100)
        length = Double.random(in: 50...100)
        step = CGFloat.random(in: 100...200)
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            scale = ud.scale > 0 ? ud.scale : Self.SCALE
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            length = ud.length > 0 ? ud.length : Self.LENGTH
            step = ud.step > 0 ? ud.step : Self.STEP
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
        
        fonts = Self.FONT
        scale = Self.SCALE
        interval = Self.INTERVAL
        length = Self.LENGTH
        step = Self.STEP
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Rain else { return }
        
        fonts.sizeRange.set(min: style.fontSizeMin, max: style.fontSizeMax)
        scale = style.scale > 0 ? style.scale : Self.SCALE
        interval = style.interval > 0 ? style.interval : Self.INTERVAL
        length = style.length > 0 ? style.length : Self.LENGTH
        step = style.step > 0 ? style.step : Self.STEP
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Rain(context: context)
        fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
        style.scale = scale
        style.interval = interval
        style.length = length
        style.step = step
        
        super.saveCoreData(context, name, style)
    }
}
