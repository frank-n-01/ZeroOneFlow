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
    
    @Published var paddingVertical: Double {
        didSet {
            ud.paddingVertical = paddingVertical
        }
    }
    
    static var maxVerticalPadding: Double = UIScreen.main.bounds.height / MAX_PADDING_DIVIDER
    static let MAX_PADDING_DIVIDER = 2.1
    
    static let FONT = Fonts(size: 0, design: .random,
                            weight: .random, min: 5, max: 30)
    static let SCALE = 2.0
    static let INTERVAL = 0.1
    static let GAP = 10.0
    static let AMPLITUDE = 50.0
    
    init() {
        scale = Self.SCALE
        interval = Self.INTERVAL
        gap = Self.GAP
        amplitude = Self.AMPLITUDE
        paddingVertical = Self.maxVerticalPadding
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        scale = Double.random(in: 1...5)
        interval = Double.random(in: 0.02...0.15)
        fonts.sizeRange.random(max: 100)
        gap = Double.random(in: 5...20)
        amplitude = Double.random(in: 20...300)
        paddingVertical = Double.random(in: (Self.maxVerticalPadding / 3)...Self.maxVerticalPadding)
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            scale = ud.scale > 0 ? ud.scale : Self.SCALE
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            gap = ud.gap > 0 ? ud.gap : Self.GAP
            amplitude = ud.amplitude
            paddingVertical = ud.paddingVertical
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = scale
        ud.interval = interval
        ud.gap = gap
        ud.amplitude = amplitude
        ud.paddingVertical = paddingVertical
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        fonts = Self.FONT
        scale = Self.SCALE
        interval = Self.INTERVAL
        gap = Self.GAP
        amplitude = Self.AMPLITUDE
        paddingVertical = Self.maxVerticalPadding
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Wave else { return }
        
        fonts.sizeRange.set(min: style.fontSizeMin, max: style.fontSizeMax)
        scale = style.scale > 0 ? style.scale : Self.SCALE
        interval = style.interval > 0 ? style.interval : Self.INTERVAL
        gap = style.gap > 0 ? style.gap : Self.GAP
        amplitude = style.amplitude
        paddingVertical = style.paddingVertical
        
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
        style.paddingVertical = paddingVertical
        
        super.saveCoreData(context, name, style)
    }
    
    func setMaxVerticalPadding(height: CGFloat) {
        Self.maxVerticalPadding = height / Self.MAX_PADDING_DIVIDER
    }
    
    func verifyVerticalPadding(height: CGFloat) {
        if paddingVertical * 2 >= height {
            paddingVertical = height / Self.MAX_PADDING_DIVIDER
        }
    }
}
