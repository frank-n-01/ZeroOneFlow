// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI
import CoreData

class SingleViewModel: FlowModeViewModel {
    
    var ud = SingleUserDefaults(Mode.single.key)
    
    @Published var interval: Double {
        didSet {
            ud.interval = self.interval
        }
    }
    
    @Published var gradientType: GradientType {
        didSet {
            ud.gradientType = self.gradientType
        }
    }
    
    let INTERVAL = 0.1
    let GRADIENT_TYPE: GradientType = .radial
    let FONT = Fonts(size: UIScreen.getScreenSize(smaller: true), design: .random, weight: .random)
    let MAX_FONT_SIZE = UIScreen.getScreenSize(smaller: false)
    
    init() {
        self.interval = INTERVAL
        self.gradientType = GRADIENT_TYPE
        super.init(ud: ud, fonts: FONT)
    }
    
    override func makeRandomStyle() {
        if isRandomStyle {
            self.interval = Double.random(in: 0.01...0.2)
            self.fonts.size = CGFloat.random(in: MAX_FONT_SIZE * 0.3 ..< MAX_FONT_SIZE * 0.6)
            self.contents.random()
            self.colors.txtRandom = true
            self.colors.bgRandom = true
            self.gradientType = GradientType.allCases.randomElement() ?? .radial
        }
    }
    
    override func applyUserDefaults() {
        super.applyUserDefaults()
        
        if ud.isSaved {
            self.interval = ud.interval > 0 ? ud.interval : INTERVAL
            self.gradientType = ud.gradientType
        }
    }
    
    override func saveUserDefaults() {
        super.saveUserDefaults()
        
        ud.interval = self.interval
        ud.gradientType = self.gradientType
    }
    
    override func resetUserDefaults() {
        super.resetUserDefaults()
        
        self.interval = INTERVAL
        self.gradientType = GRADIENT_TYPE
        self.fonts = FONT
    }
    
    override func applyCoreData<T: FlowMode>(_ context: NSManagedObjectContext, _ style: T) {
        guard let style = style as? Single else { return }
        self.interval = style.interval
        self.colors.txtRandom = style.txtRandom
        self.colors.bgRandom = style.bgRandom
        self.gradientType = GradientType(rawValue: Int(style.gradientType)) ?? .radial

        super.applyCoreData(context, style)
    }
    
    override func saveCoreData(_ context: NSManagedObjectContext, _ name: String, _ style: FlowMode? = nil) {
        let style = Single(context: context)
        style.interval = self.interval
        style.txtRandom = self.colors.txtRandom
        style.bgRandom = self.colors.bgRandom
        style.gradientType = Int16(self.gradientType.rawValue)

        super.saveCoreData(context, name, style)
    }
}
