// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class LinearViewModel: FlowModeViewModel {
    
    var ud = LinearUserDefaults(Mode.linear.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = interval
        }
    }
    
    @Published var isRepeat: Bool {
        didSet {
            ud.isRepeat = isRepeat
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
    
    init() {
        interval = LinearDefaultStyle.INTERVAL
        isRepeat = LinearDefaultStyle.REPEAT_FLOW
        linefeed = LinearDefaultStyle.LINEFEED
        indents = LinearDefaultStyle.INDENTS
        
        super.init(ud: ud, fonts: LinearDefaultStyle.FONT)
    }
    
    override func makeRandomStyle() {
        super.makeRandomStyle()
        
        interval = Double.random(in: 0.001...0.01)
        linefeed.random(max: 30)
        indents.random(max: 5)
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            interval = ud.interval > 0 ? ud.interval : LinearDefaultStyle.INTERVAL
            isRepeat = ud.isRepeat
            linefeed.set(isOn: ud.isLineFeedOn, value: ud.maxLineLength)
            indents.set(isOn: ud.isIndentOn, value: ud.maxNumberOfIndents)
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = interval
        ud.isRepeat = isRepeat
        linefeed.save(isOn: &ud.isLineFeedOn, value: &ud.maxLineLength)
        indents.save(isOn: &ud.isIndentOn, value: &ud.maxNumberOfIndents)
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        fonts = LinearDefaultStyle.FONT
        interval = LinearDefaultStyle.INTERVAL
        isRepeat = LinearDefaultStyle.REPEAT_FLOW
        linefeed = LinearDefaultStyle.LINEFEED
        indents = LinearDefaultStyle.INDENTS
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Linear else { return }
        
        interval = style.interval > 0 ? style.interval : LinearDefaultStyle.INTERVAL
        isRepeat = style.repeatFlow
        linefeed.set(isOn: style.isLineFeedOn, value: style.maxLineLength)
        indents.set(isOn: style.isIndentOn, value: style.maxNumberOfIndents)
        
        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Linear(context: context)
        style.interval = interval
        style.repeatFlow = isRepeat
        linefeed.save(isOn: &style.isLineFeedOn, value: &style.maxLineLength)
        indents.save(isOn: &style.isIndentOn, value: &style.maxNumberOfIndents)
        
        super.saveCoreData(context, name, style)
    }
}

fileprivate class LinearDefaultStyle {
    fileprivate static let FONT = Fonts(size: 18, design: .monospaced,
                                    weight: .regular, min: 10, max: 100)
    
    fileprivate static let INTERVAL = 0.005
    
    fileprivate static let REPEAT_FLOW = true
    
    fileprivate static let LINEFEED = TextFormat(isOn: false, value: 1)
    
    fileprivate static let INDENTS = TextFormat(isOn: false, value: 3)
}
