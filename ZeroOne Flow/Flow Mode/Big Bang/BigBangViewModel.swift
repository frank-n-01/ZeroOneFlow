// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class BigBangViewModel: FlowModeViewModel {
    
    var ud = BigBangUserDefaults(Mode.bigbang.key)
    
    @Published var scale: Double {
        didSet {
            ud.scale = self.scale
        }
    }
    
    @Published var interval: Double {
        didSet {
            ud.interval = self.interval
        }
    }
    
    @Published var gap: CGFloat {
        didSet {
            ud.gap = Double(self.gap)
        }
    }
    
    @Published var rotationAngle: Double {
        didSet {
            ud.rotationAngle = self.rotationAngle
        }
    }
    
    @Published var padding: Padding {
        didSet {
            self.padding.save(vertical: &ud.paddingVertical, horizontal: &ud.paddingHorizontal)
        }
    }
    
    @Published var is3D: Bool {
        didSet {
            ud.is3D = self.is3D
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
        self.scale = SCALE
        self.interval = INTERVAL
        self.gap = GAP
        self.rotationAngle = ROTATION
        self.padding = PADDING
        self.is3D = IS_3D
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            self.fonts.sizeRange.random(max: 100)
            self.scale = Double.random(in: 1...300)
            self.interval = Double.random(in: 0.01...0.15)
            self.gap = CGFloat.random(in: 5...50)
            self.rotationAngle = Double.random(in: 0.1...60)
            self.padding.random()
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            self.scale = ud.scale > 0 ? ud.scale : SCALE
            self.interval = ud.interval > 0 ? ud.interval : INTERVAL
            self.gap = ud.gap > 0 ? ud.gap : GAP
            self.rotationAngle = ud.rotationAngle > 0 ? ud.rotationAngle : ROTATION
            self.padding.set(vertical: ud.paddingVertical, horizontal: ud.paddingHorizontal)
            self.is3D = ud.is3D
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = self.scale
        ud.interval = self.interval
        ud.gap = self.gap
        ud.rotationAngle = self.rotationAngle
        self.padding.save(vertical: &ud.paddingVertical, horizontal: &ud.paddingHorizontal)
        ud.is3D = self.is3D
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        self.scale = SCALE
        self.interval = INTERVAL
        self.gap = GAP
        self.rotationAngle = ROTATION
        self.padding = PADDING
        self.is3D = IS_3D
        self.fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? BigBang else { return }
        self.scale = style.scale
        self.gap = style.gap
        self.interval = style.interval
        self.rotationAngle = style.rotationAngle
        self.padding.set(vertical: style.paddingV, horizontal: style.paddingH)
        self.is3D = style.isFlat
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = BigBang(context: context)
        self.fonts.sizeRange.save(min: &style.fontSizeMin, max: &style.fontSizeMax)
        style.scale = self.scale
        style.gap = self.gap
        style.interval = self.interval
        style.rotationAngle = self.rotationAngle
        self.padding.save(vertical: &style.paddingV, horizontal: &style.paddingH)
        style.isFlat = self.is3D
       
        super.saveCoreData(context, name, style)
    }
}
