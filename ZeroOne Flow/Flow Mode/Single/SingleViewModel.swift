// Copyright © 2021 Ni Fu. All rights reserved.

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
    
    let INTERVAL = 0.1
    let GRADIENT_TYPE: GradientType = .radial
    let FONT = Fonts(size: UIScreen.getSize(smaller: true), design: .random, weight: .random)
    let MAX_FONT_SIZE = UIScreen.getSize(smaller: false)
    
    init() {
        interval = INTERVAL
        gradientType = GRADIENT_TYPE
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        if isRandomStyle {
            interval = Double.random(in: 0.01...0.2)
            fonts.size = CGFloat.random(in: MAX_FONT_SIZE * 0.3 ..< MAX_FONT_SIZE * 0.6)
            contents.random()
            colors.txtRandom = true
            colors.bgRandom = true
            gradientType = GradientType.allCases.randomElement() ?? .radial
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            interval = ud.interval > 0 ? ud.interval : INTERVAL
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
        
        interval = INTERVAL
        gradientType = GRADIENT_TYPE
        fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Single else { return }
        
        interval = style.interval
        colors.txtRandom = style.txtRandom
        colors.bgRandom = style.bgRandom
        gradientType = GradientType(rawValue: Int(style.gradientType)) ?? .radial

        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Single(context: context)
        style.interval = interval
        style.txtRandom = colors.txtRandom
        style.bgRandom = colors.bgRandom
        style.gradientType = Int16(gradientType.rawValue)

        super.saveCoreData(context, name, style)
    }
}
