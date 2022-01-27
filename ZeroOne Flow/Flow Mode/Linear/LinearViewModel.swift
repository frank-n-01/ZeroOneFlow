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
    
    @Published var linefeed: TextFormat {
        didSet {
            linefeed.save(isOn: &ud.isLineFeedOn, value: &ud.maxLineLength)
        }
    }
    
    @Published var indents: TextFormat {
        didSet {
            indents.save(isOn: &ud.isIndentOn, value: &ud.maxNumberOfIndents)
        }
    }
    
    static let INTERVAL = 0.005
    static let REPEAT_FLOW = true
    static let LINEFEED = TextFormat(isOn: false, value: 1)
    static let FONT = Fonts(size: 18,
                            design: .monospaced,
                            weight: .regular,
                            min: 10, max: 100)
    static let INDENTS = TextFormat(isOn: false, value: 3)
    
    init() {
        interval = Self.INTERVAL
        repeatFlow = Self.REPEAT_FLOW
        linefeed = Self.LINEFEED
        indents = Self.INDENTS
        
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        interval = Double.random(in: 0.001...0.01)
        linefeed.random(max: 30)
        indents.random(max: 5)
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            repeatFlow = ud.repeatFlow
            linefeed.set(isOn: ud.isLineFeedOn, value: ud.maxLineLength)
            indents.set(isOn: ud.isIndentOn, value: ud.maxNumberOfIndents)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = interval
        ud.repeatFlow = repeatFlow
        linefeed.save(isOn: &ud.isLineFeedOn, value: &ud.maxLineLength)
        indents.save(isOn: &ud.isIndentOn, value: &ud.maxNumberOfIndents)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        fonts = Self.FONT
        interval = Self.INTERVAL
        repeatFlow = Self.REPEAT_FLOW
        linefeed = Self.LINEFEED
        indents = Self.INDENTS
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Linear else { return }
        
        interval = style.interval > 0 ? style.interval : Self.INTERVAL
        repeatFlow = style.repeatFlow
        linefeed.set(isOn: style.isLineFeedOn, value: style.maxLineLength)
        indents.set(isOn: style.isIndentOn, value: style.maxNumberOfIndents)
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Linear(context: context)
        style.interval = interval
        style.repeatFlow = repeatFlow
        linefeed.save(isOn: &style.isLineFeedOn, value: &style.maxLineLength)
        indents.save(isOn: &style.isIndentOn, value: &style.maxNumberOfIndents)
        
        super.saveCoreData(context, name, style)
    }
}
