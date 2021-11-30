// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class GeometryViewModel: FlowModeViewModel {
    
    var ud = GeometryUserDefaults(Mode.geometry.key)
    
    @Published var shape: Shapes {
        didSet {
            ud.shape = self.shape.rawValue
        }
    }
    
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
    
    @Published var isFill: Bool {
        didSet {
            ud.isFill = self.isFill
        }
    }
    
    let SHAPE: Shapes = .triangle
    let SCALE = 1.0
    let INTERVAL = 0.1
    let IS_FILL = false
    let FONT = Fonts(size: 1.5 ,design: .random, weight: .random, min: 0.1, max: 10)
    
    init() {
        self.shape = SHAPE
        self.scale = SCALE
        self.interval = INTERVAL
        self.isFill = IS_FILL
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            self.shape = Shapes.allCases.randomElement() ?? SHAPE
            self.scale = Double.random(in: 1...30)
            self.interval = Double.random(in: 0.01...0.1)
            self.isFill = Bool.random()
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            self.shape = Shapes(rawValue: ud.shape) ?? SHAPE
            self.scale = ud.scale > 0 ? ud.scale : SCALE
            self.interval = ud.interval > 0 ? ud.interval : INTERVAL
            self.isFill = ud.isFill
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.shape = self.shape.rawValue
        ud.scale = self.scale
        ud.interval = self.interval
        ud.isFill = self.isFill
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        self.shape = SHAPE
        self.scale = SCALE
        self.interval = INTERVAL
        self.isFill = IS_FILL
        self.fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Geometry else { return }
        self.shape = Shapes(rawValue: Int(style.shape)) ?? SHAPE
        self.scale = style.scale > 0 ? style.scale : SCALE
        self.interval = style.interval > 0 ? style.interval : INTERVAL
        self.isFill = style.isFill
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Geometry(context: context)
        style.shape = Int16(self.shape.rawValue)
        style.scale = self.scale
        style.interval = self.interval
        style.isFill = self.isFill
       
        super.saveCoreData(context, name, style)
    }
}
