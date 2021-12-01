// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class LinearViewModel: FlowModeViewModel {
    
    var ud = LinearUserDefaults(Mode.linear.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = interval
        }
    }
    
    @Published var repeatFlow: Bool {
        didSet {
            ud.repeatFlow = repeatFlow
        }
    }
    
    @Published var linefeed: LineFeed {
        didSet {
            linefeed.save(isOn: &ud.isLineFeedOn, maxLineLength: &ud.maxLineLength)
        }
    }
    
    let INTERVAL = 0.005
    let REPEAT_FLOW = true
    let LINEFEED = LineFeed(isOn: true, maxLineLength: 10)
    let FONT = Fonts(size: 18, design: .monospaced, weight: .regular, min: 10, max: 100)
    
    init() {
        interval = INTERVAL
        repeatFlow = REPEAT_FLOW
        linefeed = LINEFEED
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        if isRandomStyle {
            interval = Double.random(in: 0.001...0.01)
            linefeed.random(maxOfMaxLineLength: 30)
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            interval = ud.interval > 0 ? ud.interval : INTERVAL
            repeatFlow = ud.repeatFlow
            linefeed.set(isOn: ud.isLineFeedOn, maxLineLength: ud.maxLineLength)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = interval
        ud.repeatFlow = repeatFlow
        linefeed.save(isOn: &ud.isLineFeedOn, maxLineLength: &ud.maxLineLength)
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
        
        interval = style.interval > 0 ? style.interval : INTERVAL
        repeatFlow = style.repeatFlow
        linefeed.set(isOn: style.isLineFeedOn, maxLineLength: Int(style.maxLineLength))
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Linear(context: context)
        style.interval = interval
        style.repeatFlow = repeatFlow
        linefeed.save(isOn: &style.isLineFeedOn, maxLineLength: &style.maxLineLength)
        
        super.saveCoreData(context, name, style)
    }
}
