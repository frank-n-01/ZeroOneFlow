// Copyright © 2021 Ni Fu. All rights reserved.

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
            padding.save(vertical: &ud.paddingVertical, horizontal: &ud.paddingHorizontal)
        }
    }
    
    @Published var is3D: Bool {
        didSet {
            ud.is3D = is3D
        }
    }
    
    let SCALE = 150.0
    let INTERVAL = 0.1
    let GAP = 20.0
    let ROTATION = 15.0
    let PADDING = Padding(vertical: -100, horizontal: -100)
    let FONT = Fonts(size: 0, design: .random, weight: .random, min: 5, max: 30)
    let IS_3D = true
    
    init() {
        scale = SCALE
        interval = INTERVAL
        gap = GAP
        rotationAngle = ROTATION
        padding = PADDING
        is3D = IS_3D
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            fonts.sizeRange.random(max: 100)
            scale = Double.random(in: 1...300)
            interval = Double.random(in: 0.01...0.15)
            gap = CGFloat.random(in: 5...50)
            rotationAngle = Double.random(in: 0.1...60)
            padding.random()
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            scale = ud.scale > 0 ? ud.scale : SCALE
            interval = ud.interval > 0 ? ud.interval : INTERVAL
            gap = ud.gap > 0 ? ud.gap : GAP
            rotationAngle = ud.rotationAngle > 0 ? ud.rotationAngle : ROTATION
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
        padding.save(vertical: &ud.paddingVertical, horizontal: &ud.paddingHorizontal)
        ud.is3D = is3D
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        scale = SCALE
        interval = INTERVAL
        gap = GAP
        rotationAngle = ROTATION
        padding = PADDING
        is3D = IS_3D
        fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? BigBang else { return }
        
        scale = style.scale
        gap = style.gap
        interval = style.interval
        rotationAngle = style.rotationAngle
        padding.set(vertical: style.paddingV, horizontal: style.paddingH)
        is3D = style.isFlat
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = BigBang(context: context)
        fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
        style.scale = scale
        style.gap = gap
        style.interval = interval
        style.rotationAngle = rotationAngle
        padding.save(vertical: &style.paddingV, horizontal: &style.paddingH)
        style.isFlat = is3D
       
        super.saveCoreData(context, name, style)
    }
}
