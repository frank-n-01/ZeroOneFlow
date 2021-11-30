// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class LinearViewModel: FlowModeViewModel {
    
    var ud = LinearUserDefaults(Mode.linear.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = self.interval
        }
    }
    
    @Published var repeatFlow: Bool {
        didSet {
            ud.repeatFlow = self.repeatFlow
        }
    }
    
    @Published var linefeed: LineFeed {
        didSet {
            self.linefeed.save(isOn: &ud.isLineFeedOn, maxLineLength: &ud.maxLineLength)
        }
    }
    
    let INTERVAL = 0.005
    let REPEAT_FLOW = true
    let LINEFEED = LineFeed(isOn: true, maxLineLength: 10)
    let FONT = Fonts(size: 18, design: .monospaced, weight: .regular, min: 10, max: 100)
    
    init() {
        self.interval = INTERVAL
        self.repeatFlow = REPEAT_FLOW
        self.linefeed = LINEFEED
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            self.interval = Double.random(in: 0.001...0.01)
            self.linefeed.random(maxOfMaxLineLength: 30)
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            self.interval = ud.interval > 0 ? ud.interval : INTERVAL
            self.repeatFlow = ud.repeatFlow
            self.linefeed.set(isOn: ud.isLineFeedOn, maxLineLength: ud.maxLineLength)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = self.interval
        ud.repeatFlow = self.repeatFlow
        self.linefeed.save(isOn: &ud.isLineFeedOn, maxLineLength: &ud.maxLineLength)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        fonts = FONT
        interval = INTERVAL
        repeatFlow = REPEAT_FLOW
        linefeed = LINEFEED
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Linear else { return }
        self.interval = style.interval > 0 ? style.interval : INTERVAL
        self.repeatFlow = style.repeatFlow
        self.linefeed.set(isOn: style.isLineFeedOn, maxLineLength: Int(style.maxLineLength))
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Linear(context: context)
        style.interval = self.interval
        style.repeatFlow = self.repeatFlow
        self.linefeed.save(isOn: &style.isLineFeedOn, maxLineLength: &style.maxLineLength)
        
        super.saveCoreData(context, name, style)
    }
}
