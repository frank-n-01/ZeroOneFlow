// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class WaveViewModel: FlowModeViewModel {
    
    var ud = WaveUserDefaults(Mode.wave.key)
    
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

    @Published var gap: Double {
        didSet {
            ud.gap = gap
        }
    }
    
    @Published var amplitude: Double {
        didSet {
            ud.amplitude = amplitude
        }
    }
    
    static let FONT = Fonts(size: 0, design: .random,
                            weight: .ultraLight, min: 5, max: 30)
    static let SCALE = 1.0
    static let INTERVAL = 0.05
    static let GAP = 5.0
    static let AMPLITUDE = 50.0
    
    init() {
        scale = Self.SCALE
        interval = Self.INTERVAL
        gap = Self.GAP
        amplitude = Self.AMPLITUDE
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        scale = Double.random(in: 1...200)
        interval = Double.random(in: 0.02...0.1)
        fonts.sizeRange.random(max: 100)
        gap = Double.random(in: 20...150)
        amplitude = Double.random(in: 30...300)
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            scale = ud.scale > 0 ? ud.scale : Self.SCALE
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            gap = ud.gap > 0 ? ud.gap : Self.GAP
            amplitude = ud.amplitude
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = scale
        ud.interval = interval
        ud.gap = gap
        ud.amplitude = amplitude
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        fonts = Self.FONT
        scale = Self.SCALE
        interval = Self.INTERVAL
        gap = Self.GAP
        amplitude = Self.AMPLITUDE
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Wave else { return }
        
        fonts.sizeRange.set(min: style.fontSizeMin, max: style.fontSizeMax)
        scale = style.scale > 0 ? style.scale : Self.SCALE
        interval = style.interval > 0 ? style.interval : Self.INTERVAL
        gap = style.gap > 0 ? style.gap : Self.GAP
        amplitude = style.amplitude
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Wave(context: context)
        fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
        style.scale = scale
        style.interval = interval
        style.gap = gap
        style.amplitude = amplitude
        
        super.saveCoreData(context, name, style)
    }
}
