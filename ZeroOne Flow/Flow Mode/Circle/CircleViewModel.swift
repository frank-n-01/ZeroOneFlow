// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class CircleViewModel: FlowModeViewModel {
    
    var ud = CircleUserDefaults(Mode.circle.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = self.interval
        }
    }
    
    @Published var depth: Double {
        didSet {
            ud.depth = self.depth
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
    
    let INTERVAL = 0.1
    let DEPTH = 150.0
    let GAP = 5.0
    let ROTATION = 112.0
    let FONT = Fonts(size: 18, design: .random, weight: .random, min: 10, max: 100)
    
    init() {
        self.interval = INTERVAL
        self.depth = DEPTH
        self.gap = GAP
        self.rotationAngle = ROTATION
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            self.interval = Double.random(in: 0.02...0.1)
            self.depth = Double.random(in: 1...300)
            self.gap = CGFloat.random(in: 0.01...15)
            self.rotationAngle = Double.random(in: 60...180)
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            self.interval = ud.interval > 0 ? ud.interval : INTERVAL
            self.depth = ud.depth > 0 ? ud.depth : DEPTH
            self.gap = ud.gap > 0 ? ud.gap : GAP
            self.rotationAngle = ud.rotationAngle > 0 ? ud.rotationAngle : ROTATION
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = self.interval
        ud.depth = self.depth
        ud.gap = self.gap
        ud.rotationAngle = self.rotationAngle
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        self.interval = INTERVAL
        self.depth = DEPTH
        self.gap = GAP
        self.rotationAngle = ROTATION
        self.fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Circle else { return }
        self.depth = style.depth
        self.gap = style.gap
        self.interval = style.interval
        self.rotationAngle = style.rotationAngle
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Circle(context: context)
        style.depth = self.depth
        style.gap = self.gap
        style.interval = self.interval
        style.rotationAngle = self.rotationAngle
       
        super.saveCoreData(context, name, style)
    }
}
