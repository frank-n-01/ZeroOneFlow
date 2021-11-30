// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class FlyViewModel: FlowModeViewModel {
    
    var ud = FlyUserDefaults(Mode.fly.key)
    
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
    
    @Published var padding: Padding {
        didSet {
            self.padding.save(vertical: &ud.paddingVertical, horizontal: &ud.paddingHorizontal)
        }
    }
    
    let SCALE = 10.0
    let INTERVAL = 0.1
    let PADDING = Padding(vertical: 0, horizontal: 0)
    let FONT = Fonts(size: 20, design: .random, weight: .random, min: 10, max: 100)
    
    init() {
        self.scale = SCALE
        self.interval = INTERVAL
        self.padding = PADDING
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            self.scale = Double.random(in: 1...300)
            self.interval = Double.random(in: 0.01...0.1)
            self.padding.random()
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            self.scale = ud.scale > 0 ? ud.scale : SCALE
            self.interval = ud.interval > 0 ? ud.interval : INTERVAL
            self.padding.set(vertical: ud.paddingVertical, horizontal: ud.paddingHorizontal)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = self.scale
        ud.interval = self.interval
        self.padding.save(vertical: &ud.paddingVertical, horizontal: &ud.paddingHorizontal)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        self.scale = SCALE
        self.fonts = FONT
        self.interval = INTERVAL
        self.padding = PADDING
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Fly else { return }
        self.scale = style.numberOfFlies
        self.interval = style.interval
        self.padding.set(vertical: style.paddingV, horizontal: style.paddingH)
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Fly(context: context)
        style.numberOfFlies = self.scale
        style.interval = self.interval
        self.padding.save(vertical: &style.paddingV, horizontal: &style.paddingH)
       
        super.saveCoreData(context, name, style)
    }
}
