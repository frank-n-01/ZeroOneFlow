// Copyright © 2021-22 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

/// The super class of the flow mode view modesl.
class FlowModeViewModel: ObservableObject {
    
    /// The common UserDefaults properties.
    var flowModeUD: FlowModeUserDefaults
    
    /// The flow is playing or not.
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
        isFlowing = false
        flowModeUD = ud
        self.fonts = fonts
        colors = Colors()
        contents = Contents()
        
        if flowModeUD.isSaved {
            // Apply the saved style.
            applyUserDefaults()
        } else {
            // Save the first style.
            saveUserDefaults()
        }
    }
    
    /// Make a random style in the flow mode.
    ///
    /// On the condition that the random style mode is activated.
    func makeRandomStyle() {
        fonts.random()
        colors.random()
        contents.random()
    }
    
    /// Apply the style saved in the flow mode's UserDefaults.
    func applyUserDefaults() {
        if flowModeUD.isSaved {
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
    
    /// Save the current style int the flow mode's UserDefaults.
    func saveUserDefaults() {
        flowModeUD.saveFonts(fonts)
        flowModeUD.saveColors(colors)
        flowModeUD.saveContents(contents)
        
        if !flowModeUD.isSaved {
            flowModeUD.isSaved = true
        }
    }
    
    /// Reset the style saved in the flow mode's UserDefaults.
    func resetUserDefaults() {
        flowModeUD.isSaved = false
        colors.reset()
        contents.reset()
    }
    
    /// Apply the style from Core Data.
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
    
    /// Save the style in Core Data.
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
