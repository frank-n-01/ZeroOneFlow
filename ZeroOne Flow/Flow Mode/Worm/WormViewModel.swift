// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class WormViewModel: FlowModeViewModel {
    
    var ud = WormUserDefaults(Mode.worm.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = self.interval
        }
    }
    
    @Published var length: Double {
        didSet {
            ud.length = self.length
        }
    }
    
    @Published var step: Double {
        didSet {
            ud.step = self.step
        }
    }
    
    @Published var crawling: Double {
        didSet {
            ud.crawling = self.crawling
        }
    }
    
    @Published var padding: Padding {
        didSet {
            self.padding.save(vertical: &ud.paddingVertical, horizontal: &ud.paddingHorizontal)
        }
    }
    
    let INTERVAL = 0.08
    let LENGTH = 20.0
    let STEP = 20.0
    let CRAWLING = 20.0
    let PADDING = Padding(vertical: 30, horizontal: 30)
    let FONT = Fonts(size: 20, design: .random, weight: .random, min: 5, max: 100)
    
    init() {
        self.interval = INTERVAL
        self.length = LENGTH
        self.step = STEP
        self.crawling = CRAWLING
        self.padding = PADDING
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            self.interval = Double.random(in: 0.01...0.05)
            self.length = Double.random(in: 1...100)
            self.step = Double.random(in: 10...100)
            self.crawling = Double.random(in: 10...100)
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            self.interval = ud.interval > 0 ? ud.interval : INTERVAL
            self.length = ud.length > 0 ? ud.length : LENGTH
            self.step = ud.step  > 0 ? ud.step : STEP
            self.crawling = ud.crawling > 0 ? ud.crawling : CRAWLING
            self.padding.set(vertical: ud.paddingVertical, horizontal: ud.paddingHorizontal)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = self.interval
        ud.length = self.length
        ud.step = self.step
        ud.crawling = self.crawling
        self.padding.save(vertical: &ud.paddingVertical, horizontal: &ud.paddingHorizontal)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        self.interval = INTERVAL
        self.length = LENGTH
        self.step = STEP
        self.crawling = CRAWLING
        self.padding = PADDING
        self.fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Worm else { return }
        self.interval = style.interval > 0 ? style.interval : INTERVAL
        self.length = style.length > 0 ? style.length : LENGTH
        self.step = style.step > 0 ? style.step : STEP
        self.crawling = style.crawling > 0 ? style.crawling : CRAWLING
        self.padding.set(vertical: style.paddingV, horizontal: style.paddingH)
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Worm(context: context)
        style.interval = self.interval
        style.length = self.length
        style.step = self.step
        style.crawling = self.crawling
        self.padding.save(vertical: &style.paddingV, horizontal: &style.paddingH)
        
        super.saveCoreData(context, name, style)
    }
}
