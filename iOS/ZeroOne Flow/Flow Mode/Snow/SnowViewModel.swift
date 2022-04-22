// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class SnowViewModel: FlowModeViewModel {
    
    var ud = SnowUserDefaults(Mode.snow.key)
    
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

    @Published var wind: Double {
        didSet {
            ud.wind = wind
        }
    }
    
    @Published var step: Double {
        didSet {
            ud.step = step
        }
    }
    
    init() {
        scale = SnowDefault.SCALE
        interval = SnowDefault.INTERVAL
        wind = SnowDefault.WIND
        step = SnowDefault.FALL
        super.init(ud: ud, fonts: SnowDefault.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        scale = Double.random(in: 1...200)
        interval = Double.random(in: 0.02...0.1)
        fonts.sizeRange.random(max: 100)
        wind = Double.random(in: 20...150)
        step = CGFloat.random(in: 20...200)
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            scale = ud.scale > 0 ? ud.scale : SnowDefault.SCALE
            interval = ud.interval > 0 ? ud.interval : SnowDefault.INTERVAL
            wind = ud.wind > 0 ? ud.wind : SnowDefault.WIND
            step = ud.step > 0 ? ud.step : SnowDefault.FALL
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = scale
        ud.interval = interval
        ud.wind = wind
        ud.step = step
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        fonts = SnowDefault.FONT
        scale = SnowDefault.SCALE
        interval = SnowDefault.INTERVAL
        wind = SnowDefault.WIND
        step = SnowDefault.FALL
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Snow else { return }
        
        fonts.sizeRange.set(min: style.fontSizeMin, max: style.fontSizeMax)
        scale = style.scale > 0 ? style.scale : SnowDefault.SCALE
        interval = style.interval > 0 ? style.interval : SnowDefault.INTERVAL
        wind = style.wind > 0 ? style.wind : SnowDefault.WIND
        step = style.step > 0 ? style.step : SnowDefault.FALL
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Snow(context: context)
        fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
        style.scale = scale
        style.interval = interval
        style.wind = wind
        style.step = step
        
        super.saveCoreData(context, name, style)
    }
    
    private class SnowDefault {
        static let FONT = Fonts(size: 0, design: .random, weight: .ultraLight, min: 5, max: 30)
        static let SCALE = 100.0
        static let INTERVAL = 0.05
        static let WIND = 50.0
        static let FALL = 100.0
    }
}

