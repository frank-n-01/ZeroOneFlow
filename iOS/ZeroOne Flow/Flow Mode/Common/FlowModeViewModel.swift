// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class FlowModeViewModel: ObservableObject {
    var flowModeUD: FlowModeUserDefaults
    
    @Published var isFlowing: Bool
    
    @Published var fonts: Fonts {
        didSet {
            flowModeUD.saveFonts(fonts)
        }
    }
    
    @Published var colors: Colors {
        didSet {
            flowModeUD.saveColors(colors)
        }
    }
    
    @Published var contents: Contents {
        didSet {
            flowModeUD.saveContents(contents)
        }
    }
    
    init(ud: FlowModeUserDefaults, fonts: Fonts) {
        self.isFlowing = false
        self.flowModeUD = ud
        self.fonts = fonts
        self.colors = Colors()
        self.contents = Contents()
        
        if self.flowModeUD.isInitialized {
            applyUserDefaults()
        } else {
            saveUserDefaults()
        }
    }
    
    func makeRandomStyle() {
        fonts.random()
        colors.random()
        contents.random()
    }
    
    func applyUserDefaults() {
        if flowModeUD.isInitialized {
            fonts.set(size: flowModeUD.fontSize,
                      design: flowModeUD.fontDesign,
                      weight: flowModeUD.fontWeight,
                      min: flowModeUD.fontSizeMin,
                      max: flowModeUD.fontSizeMax)
            
            colors.set(txtR: flowModeUD.txtR,
                       txtG: flowModeUD.txtG,
                       txtB: flowModeUD.txtB,
                       txtA: flowModeUD.txtA,
                       txtRandom: flowModeUD.txtRandom,
                       bgR: flowModeUD.bgR,
                       bgG: flowModeUD.bgG,
                       bgB: flowModeUD.bgB,
                       bgA: flowModeUD.bgA,
                       bgRandom: flowModeUD.bgRandom)
            
            contents.set(type: flowModeUD.contentType,
                         number: flowModeUD.number,
                         language: flowModeUD.language,
                         symbol: flowModeUD.symbol,
                         customValue1: flowModeUD.customValue1 ?? "",
                         customValue2: flowModeUD.customValue2 ?? "",
                         code: flowModeUD.code)
        }
    }
    
    func saveUserDefaults() {
        flowModeUD.saveFonts(fonts)
        flowModeUD.saveColors(colors)
        flowModeUD.saveContents(contents)
        
        if !flowModeUD.isInitialized {
            flowModeUD.isInitialized = true
        }
    }
    
    func resetUserDefaults() {
        flowModeUD.isInitialized = false
        colors.reset()
        contents.reset()
    }
    
    func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        fonts.set(size: CGFloat(style.fontSize),
                  design: Int(style.fontDesign),
                  weight: Int(style.fontWeight))
        
        colors.set(txtR: style.txtR,
                   txtG: style.txtG,
                   txtB: style.txtB,
                   txtA: style.txtA,
                   bgR: style.bgR,
                   bgG: style.bgG,
                   bgB: style.bgB,
                   bgA: style.bgA)
        
        contents.set(type: Int(style.valueType),
                     number: Int(style.number),
                     language: Int(style.language),
                     symbol: Int(style.symbol),
                     customValue1: style.customValue1 ?? "",
                     customValue2: style.customValue2 ?? "",
                     code: Int(style.code))
    }
    
    func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        guard let style = style else { return }
        
        style.date = Date()
        style.name = name
        
        fonts.save(size: &style.fontSize,
                   design: &style.fontDesign,
                   weight: &style.fontWeight)
        
        colors.save(txtR: &style.txtR,
                    txtG: &style.txtG,
                    txtB: &style.txtB,
                    txtA: &style.txtA,
                    bgR: &style.bgR,
                    bgG: &style.bgG,
                    bgB: &style.bgB,
                    bgA: &style.bgA)
        
        contents.save(type: &style.valueType,
                      number: &style.number,
                      language: &style.language,
                      symbol: &style.symbol,
                      custom1: &style.customValue1,
                      custom2: &style.customValue2,
                      code: &style.code)
        
        if context.hasChanges {
            try? context.save()
        }
    }
}
