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
    
    @Published var floating: Double {
        didSet {
            ud.floating = floating
        }
    }
    
    static let FONT = Fonts(size: 0, design: .random,
                            weight: .ultraLight, min: 5, max: 30)
    static let SCALE = 100.0
    static let INTERVAL = 0.05
    static let WIND = 50.0
    static let STEP = 100.0
    static let FLOATING = -10.0
    
    init() {
        scale = Self.SCALE
        interval = Self.INTERVAL
        wind = Self.WIND
        step = Self.STEP
        floating = Self.FLOATING
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        scale = Double.random(in: 1...200)
        interval = Double.random(in: 0.02...0.1)
        fonts.sizeRange.random(max: 100)
        wind = Double.random(in: 10...150)
        step = CGFloat.random(in: 50...200)
        floating = Double.random(in: -(step / 2)...(step / 2))
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            scale = ud.scale > 0 ? ud.scale : Self.SCALE
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            wind = ud.wind > 0 ? ud.wind : Self.WIND
            step = ud.step > 0 ? ud.step : Self.STEP
            floating = ud.floating > 0 ? ud.floating : Self.FLOATING
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = scale
        ud.interval = interval
        ud.wind = wind
        ud.step = step
        ud.floating = floating
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        fonts = Self.FONT
        scale = Self.SCALE
        interval = Self.INTERVAL
        wind = Self.WIND
        step = Self.STEP
        floating = Self.FLOATING
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Snow else { return }
        
        fonts.sizeRange.set(min: style.fontSizeMin, max: style.fontSizeMax)
        scale = style.scale > 0 ? style.scale : Self.SCALE
        interval = style.interval > 0 ? style.interval : Self.INTERVAL
        wind = style.wind > 0 ? style.wind : Self.WIND
        step = style.step > 0 ? style.step : Self.STEP
        floating = style.floating
        
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
        style.floating = floating
        
        super.saveCoreData(context, name, style)
    }
}

