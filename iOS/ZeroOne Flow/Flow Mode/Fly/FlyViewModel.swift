// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class FlyViewModel: FlowModeViewModel {
    
    var ud = FlyUserDefaults(Mode.fly.key)
    
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
    
    @Published var padding: Padding {
        didSet {
            padding.save(vertical: &ud.paddingVertical,
                         horizontal: &ud.paddingHorizontal)
        }
    }
    
    static let FONT = Fonts(size: 20, design: .random,
                            weight: .random, min: 10, max: 100)
    static let SCALE = 10.0
    static let INTERVAL = 0.1
    static let PADDING = Padding(vertical: 0, horizontal: 0)
    
    init() {
        scale = Self.SCALE
        interval = Self.INTERVAL
        padding = Self.PADDING
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        scale = Double.random(in: 1...300)
        interval = Double.random(in: 0.01...0.1)
        padding.random()
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            scale = ud.scale > 0 ? ud.scale : Self.SCALE
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            padding.set(vertical: ud.paddingVertical,
                        horizontal: ud.paddingHorizontal)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.scale = scale
        ud.interval = interval
        padding.save(vertical: &ud.paddingVertical,
                     horizontal: &ud.paddingHorizontal)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        scale = Self.SCALE
        fonts = Self.FONT
        interval = Self.INTERVAL
        padding = Self.PADDING
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Fly else { return }
        
        scale = style.numberOfFlies
        interval = style.interval
        padding.set(vertical: style.paddingV, horizontal: style.paddingH)
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Fly(context: context)
        style.numberOfFlies = scale
        style.interval = interval
        padding.save(vertical: &style.paddingV, horizontal: &style.paddingH)
       
        super.saveCoreData(context, name, style)
    }
}
