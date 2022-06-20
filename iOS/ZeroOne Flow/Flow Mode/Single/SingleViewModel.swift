// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class SingleViewModel: FlowModeViewModel {
    
    var ud = SingleUserDefaults(Mode.single.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = interval
        }
    }
    
    @Published var gradientType: GradientType {
        didSet {
            ud.gradientType = gradientType
        }
    }
    
    static let FONT = Fonts(size: UIScreen.getSize(smaller: true),
                            design: .random, weight: .random)
    static let INTERVAL = 0.1
    static let GRADIENT_TYPE: GradientType = .radial
    static let MAX_FONT_SIZE = UIScreen.getSize(smaller: false)
    
    init() {
        interval = Self.INTERVAL
        gradientType = Self.GRADIENT_TYPE
        super.init(ud: ud, fonts: Self.FONT)
    }
    
    override func makeRandomStyle() {
        interval = Double.random(in: 0.01...0.2)
        fonts.size = CGFloat.random(
            in: Self.MAX_FONT_SIZE * 0.2 ..< Self.MAX_FONT_SIZE * 0.6)
        contents.random()
        colors.txtRandom = true
        colors.bgRandom = true
        gradientType = GradientType.allCases.randomElement() ?? Self.GRADIENT_TYPE
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isInitialized {
            interval = ud.interval > 0 ? ud.interval : Self.INTERVAL
            gradientType = ud.gradientType
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = interval
        ud.gradientType = gradientType
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        interval = Self.INTERVAL
        gradientType = Self.GRADIENT_TYPE
        fonts = Self.FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext,
                                             _ style: T) {
        guard let style = style as? Single else { return }
        
        interval = style.interval
        gradientType = GradientType(rawValue: Int(style.gradientType)) ?? Self.GRADIENT_TYPE
        super.applyCoreData(context, style)
        colors.txtRandom = style.txtRandom
        colors.bgRandom = style.bgRandom
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext,
                               _ name: String, _ style: FlowMode? = nil) {
        let style = Single(context: context)
        style.interval = interval
        style.txtRandom = colors.txtRandom
        style.bgRandom = colors.bgRandom
        style.gradientType = Int16(gradientType.rawValue)

        super.saveCoreData(context, name, style)
    }
}
