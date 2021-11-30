// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

/// A flow mode's view model class.
class FlowModeViewModel: ObservableObject {
    
    var flowModeUD: FlowModeUserDefaults
    
    @Published var start: Bool
    
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
            flowModeUD.saveContentTypes(contents)
        }
    }
    
    @Published var isRandomStyle: Bool {
        didSet {
            flowModeUD.isRandomStyle = self.isRandomStyle
        }
    }
    
    init(ud: FlowModeUserDefaults, fonts: Fonts) {
        self.start = false
        self.isRandomStyle = false
        self.flowModeUD = ud
        self.fonts = fonts
        self.colors = Colors()
        self.contents = Contents()
        
        if flowModeUD.isSaved {
            applyUserDefaults()
        } else {
            saveUserDefaults() // If do not save the first style, the auto save would not be enabled.
        }
    }
    
    /// Make a random style in the flow mode.
    func makeRandomStyle() {
        if isRandomStyle {
            fonts.random()
            colors.random()
            contents.random()
        }
    }
    
    /// Apply the style saved in the flow mode's UserDefaults.
    func applyUserDefaults() {
        if flowModeUD.isSaved {
            fonts.set(size: flowModeUD.fontSize, design: flowModeUD.fontDesign, weight: flowModeUD.fontWeight,
                      min: flowModeUD.fontSizeMin, max: flowModeUD.fontSizeMax)
            colors.set(txtR: flowModeUD.txtR, txtG: flowModeUD.txtG, txtB: flowModeUD.txtB, txtA: flowModeUD.txtA, txtRandom: flowModeUD.txtRandom,
                       bgR: flowModeUD.bgR, bgG: flowModeUD.bgG, bgB: flowModeUD.bgB, bgA: flowModeUD.bgA, bgRandom: flowModeUD.bgRandom)
            contents.set(type: flowModeUD.contentType, number: flowModeUD.number, language: flowModeUD.language,
                             symbol: flowModeUD.symbol, customValue1: flowModeUD.customValue1 ?? "", customValue2: flowModeUD.customValue2 ?? "")
            self.isRandomStyle = flowModeUD.isRandomStyle
        }
    }
    
    /// Save the current style int the flow mode's UserDefaults.
    func saveUserDefaults() {
        flowModeUD.saveFonts(fonts)
        flowModeUD.saveColors(colors)
        flowModeUD.saveContentTypes(contents)
        flowModeUD.isRandomStyle = self.isRandomStyle
        if !flowModeUD.isSaved {
            flowModeUD.isSaved = true
        }
    }
    
    /// Reset the style saved in the flow mode's UserDefaults.
    func resetUserDefaults() {
        flowModeUD.isSaved = false
        colors.reset()
        contents.reset()
        isRandomStyle = false
    }
    
    /// Apply the style from Core Data.
    func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        self.fonts.set(size: CGFloat(style.fontSize), design: Int(style.fontDesign), weight: Int(style.fontWeight))
        self.colors.set(txtR: style.txtR, txtG: style.txtG, txtB: style.txtB, txtA: style.txtA,
                        bgR: style.bgR, bgG: style.bgG, bgB: style.bgB, bgA: style.bgA)
        self.contents.set(type: Int(style.valueType), number: Int(style.number), language: Int(style.language),
                              symbol: Int(style.symbol), customValue1: style.customValue1 ?? "", customValue2: style.customValue2 ?? "")
        self.isRandomStyle = false
    }
    
    /// Save the style in Core Data.
    func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        guard let style = style else { return }
        style.date = Date()
        style.name = name
        self.fonts.save(size: &style.fontSize, design: &style.fontDesign, weight: &style.fontWeight)
        self.colors.save(txtR: &style.txtR, txtG: &style.txtG, txtB: &style.txtB, txtA: &style.txtA,
                         bgR: &style.bgR, bgG: &style.bgG, bgB: &style.bgB, bgA: &style.bgA)
        self.contents.save(type: &style.valueType, number: &style.number, language: &style.language,
                             symbol: &style.symbol, custom1: &style.customValue1, custom2: &style.customValue2)
        
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func getDownCasted<T>(onFailure defaultValue: T) -> T {
        guard let viewModel = self as? T else { return defaultValue }
        return viewModel
    }
}
