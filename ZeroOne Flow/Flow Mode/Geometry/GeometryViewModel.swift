// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class GeometryViewModel: FlowModeViewModel {
    
    var ud = GeometryUserDefaults(Mode.geometry.key)
    
    @Published var shape: Shapes {
        didSet {
            ud.shape = shape.rawValue
        }
    }
    
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
    
    @Published var isFill: Bool {
        didSet {
            ud.isFill = isFill
        }
    }
    
    let SHAPE: Shapes = .triangle
    let SCALE = 1.0
    let INTERVAL = 0.1
    let IS_FILL = false
    let FONT = Fonts(size: 1.5 ,design: .random, weight: .random, min: 0.1, max: 10)
    
    init() {
        shape = SHAPE
        scale = SCALE
        interval = INTERVAL
        isFill = IS_FILL
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            shape = Shapes.allCases.randomElement() ?? SHAPE
            scale = Double.random(in: 1...30)
            interval = Double.random(in: 0.01...0.1)
            isFill = Bool.random()
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            shape = Shapes(rawValue: ud.shape) ?? SHAPE
            scale = ud.scale > 0 ? ud.scale : SCALE
            interval = ud.interval > 0 ? ud.interval : INTERVAL
            isFill = ud.isFill
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.shape = shape.rawValue
        ud.scale = scale
        ud.interval = interval
        ud.isFill = isFill
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        shape = SHAPE
        scale = SCALE
        interval = INTERVAL
        isFill = IS_FILL
        fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Geometry else { return }
        
        shape = Shapes(rawValue: Int(style.shape)) ?? SHAPE
        scale = style.scale > 0 ? style.scale : SCALE
        interval = style.interval > 0 ? style.interval : INTERVAL
        isFill = style.isFill
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Geometry(context: context)
        style.shape = Int16(shape.rawValue)
        style.scale = scale
        style.interval = interval
        style.isFill = isFill
       
        super.saveCoreData(context, name, style)
    }
}
