// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class WormViewModel: FlowModeViewModel {
    
    var ud = WormUserDefaults(Mode.worm.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = interval
        }
    }
    
    @Published var length: Double {
        didSet {
            ud.length = length
        }
    }
    
    @Published var step: Double {
        didSet {
            ud.step = step
        }
    }
    
    @Published var crawling: Double {
        didSet {
            ud.crawling = crawling
        }
    }
    
    @Published var padding: Padding {
        didSet {
            padding.save(vertical: &ud.paddingVertical,
                         horizontal: &ud.paddingHorizontal)
        }
    }
    
    static let INTERVAL = 0.08
    static let LENGTH = 20.0
    static let STEP = 20.0
    static let CRAWLING = 20.0
    static let PADDING = Padding(vertical: 30, horizontal: 30)
    static let FONT = Fonts(size: 20,
                            design: .random,
                            weight: .random,
                            min: 5, max: 100)
    
    init() {
        interval = Self.INTERVAL
        length = Self.LENGTH
        step = Self.STEP
        crawling = Self.CRAWLING
        padding = Self.PADDING
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            interval = Double.random(in: 0.01...0.05)
            length = Double.random(in: 1...100)
            step = Double.random(in: 10...100)
            crawling = Double.random(in: 10...100)
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            length = ud.length > 0 ? ud.length : Self.LENGTH
            step = ud.step  > 0 ? ud.step : Self.STEP
            crawling = ud.crawling > 0 ? ud.crawling : Self.CRAWLING
            padding.set(vertical: ud.paddingVertical,
                        horizontal: ud.paddingHorizontal)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = interval
        ud.length = length
        ud.step = step
        ud.crawling = crawling
        padding.save(vertical: &ud.paddingVertical,
                     horizontal: &ud.paddingHorizontal)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        interval = Self.INTERVAL
        length = Self.LENGTH
        step = Self.STEP
        crawling = Self.CRAWLING
        padding = Self.PADDING
        fonts = Self.FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Worm else { return }
        
        interval = style.interval > 0 ? style.interval : Self.INTERVAL
        length = style.length > 0 ? style.length : Self.LENGTH
        step = style.step > 0 ? style.step : Self.STEP
        crawling = style.crawling > 0 ? style.crawling : Self.CRAWLING
        padding.set(vertical: style.paddingV, horizontal: style.paddingH)
       
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String,
                               _ style: FlowMode? = nil) {
        let style = Worm(context: context)
        style.interval = interval
        style.length = length
        style.step = step
        style.crawling = crawling
        padding.save(vertical: &style.paddingV, horizontal: &style.paddingH)
        
        super.saveCoreData(context, name, style)
    }
}
