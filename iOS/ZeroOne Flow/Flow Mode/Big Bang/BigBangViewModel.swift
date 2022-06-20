// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class BigBangViewModel: FlowModeViewModel {
    
    var ud = BigBangUserDefaults(Mode.bigbang.key)
    
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
    
    @Published var gap: CGFloat {
        didSet {
            ud.gap = Double(gap)
        }
    }
    
    @Published var rotationAngle: Double {
        didSet {
            ud.rotationAngle = rotationAngle
        }
    }
    
    @Published var padding: Padding {
        didSet {
            padding.save(vertical: &ud.paddingVertical,
                         horizontal: &ud.paddingHorizontal)
        }
    }
    
    @Published var is3D: Bool {
        didSet {
            ud.is3D = is3D
        }
    }
    
    static let FONT = Fonts(size: 0, design: .random,
                            weight: .random, min: 5, max: 30)
    static let SCALE = 150.0
    static let INTERVAL = 0.1
    static let GAP = 20.0
    static let ROTATION = 15.0
    static let PADDING = Padding(vertical: -100, horizontal: -100)
    static let IS_3D = true
    static let INITIAL_FLOW_COUNT = -5
    static let RETURNED_FLOW_COUNT = -15
    
    init() {
        scale = Self.SCALE
        interval = Self.INTERVAL
        gap = Self.GAP
        rotationAngle = Self.ROTATION
        padding = Self.PADDING
        is3D = Self.IS_3D
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        fonts.sizeRange.random(max: 100)
        scale = Double.random(in: 1...300)
        interval = Double.random(in: 0.01...0.15)
        gap = CGFloat.random(in: 5...50)
        rotationAngle = Double.random(in: 0.1...60)
        is3D = Bool.random()
        padding.random()
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            scale = ud.scale > 0 ? ud.scale : Self.SCALE
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            gap = ud.gap > 0 ? ud.gap : Self.GAP
            rotationAngle = ud.rotationAngle > 0 ? ud.rotationAngle : Self.ROTATION
            padding.set(vertical: ud.paddingVertical, horizontal: ud.paddingHorizontal)
            is3D = ud.is3D
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = scale
        ud.interval = interval
        ud.gap = gap
        ud.rotationAngle = rotationAngle
        padding.save(vertical: &ud.paddingVertical,
                     horizontal: &ud.paddingHorizontal)
        ud.is3D = is3D
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        scale = Self.SCALE
        interval = Self.INTERVAL
        gap = Self.GAP
        rotationAngle = Self.ROTATION
        padding = Self.PADDING
        is3D = Self.IS_3D
        fonts = Self.FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? BigBang else { return }
        
        scale = style.scale
        gap = style.gap
        interval = style.interval
        rotationAngle = style.rotationAngle
        padding.set(vertical: style.paddingV, horizontal: style.paddingH)
        is3D = style.isFlat
        fonts.sizeRange.set(min: style.fontSizeMin, max: style.fontSizeMax)
         
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = BigBang(context: context)
        style.scale = scale
        style.gap = gap
        style.interval = interval
        style.rotationAngle = rotationAngle
        padding.save(vertical: &style.paddingV, horizontal: &style.paddingH)
        style.isFlat = is3D
        fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
       
        super.saveCoreData(context, name, style)
    }
}
