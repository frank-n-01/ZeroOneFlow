// Copyright © 2021-2022 Ni Fu. All rights reserved.

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
    
    static let INTERVAL = 0.1
    static let DEPTH = 150.0
    static let GAP = 5.0
    static let ROTATION = 112.0
    static let FONT = Fonts(size: 18,
                            design: .random,
                            weight: .random,
                            min: 10, max: 100)
    
    init() {
        interval = Self.INTERVAL
        depth = Self.DEPTH
        gap = Self.GAP
        rotationAngle = Self.ROTATION
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        interval = Double.random(in: 0.02...0.1)
        depth = Double.random(in: 1...300)
        gap = CGFloat.random(in: 0.01...15)
        rotationAngle = Double.random(in: 60...180)
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            depth = ud.depth > 0 ? ud.depth : Self.DEPTH
            gap = ud.gap > 0 ? ud.gap : Self.GAP
            rotationAngle = ud.rotationAngle > 0 ? ud.rotationAngle : Self.ROTATION
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
        
        interval = Self.INTERVAL
        depth = Self.DEPTH
        gap = Self.GAP
        rotationAngle = Self.ROTATION
        fonts = Self.FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Circle else { return }
        
        depth = style.depth
        gap = style.gap
        interval = style.interval
        rotationAngle = style.rotationAngle
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Circle(context: context)
        style.depth = depth
        style.gap = gap
        style.interval = interval
        style.rotationAngle = rotationAngle
       
        super.saveCoreData(context, name, style)
    }
}
