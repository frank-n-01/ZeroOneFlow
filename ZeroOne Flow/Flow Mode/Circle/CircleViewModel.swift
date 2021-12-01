// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class CircleViewModel: FlowModeViewModel {
    
    var ud = CircleUserDefaults(Mode.circle.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = interval
        }
    }
    
    @Published var depth: Double {
        didSet {
            ud.depth = depth
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
    
    let INTERVAL = 0.1
    let DEPTH = 150.0
    let GAP = 5.0
    let ROTATION = 112.0
    let FONT = Fonts(size: 18, design: .random, weight: .random, min: 10, max: 100)
    
    init() {
        interval = INTERVAL
        depth = DEPTH
        gap = GAP
        rotationAngle = ROTATION
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            interval = Double.random(in: 0.02...0.1)
            depth = Double.random(in: 1...300)
            gap = CGFloat.random(in: 0.01...15)
            rotationAngle = Double.random(in: 60...180)
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            interval = ud.interval > 0 ? ud.interval : INTERVAL
            depth = ud.depth > 0 ? ud.depth : DEPTH
            gap = ud.gap > 0 ? ud.gap : GAP
            rotationAngle = ud.rotationAngle > 0 ? ud.rotationAngle : ROTATION
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = interval
        ud.depth = depth
        ud.gap = gap
        ud.rotationAngle = rotationAngle
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        interval = INTERVAL
        depth = DEPTH
        gap = GAP
        rotationAngle = ROTATION
        fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Circle else { return }
        
        depth = style.depth
        gap = style.gap
        interval = style.interval
        rotationAngle = style.rotationAngle
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Circle(context: context)
        style.depth = depth
        style.gap = gap
        style.interval = interval
        style.rotationAngle = rotationAngle
       
        super.saveCoreData(context, name, style)
    }
}
