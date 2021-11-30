// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct FontRangeView: View {
    @Binding var fonts: Fonts
    var min: CGFloat
    var max: CGFloat
    var isRandom: Bool
    
    var body: some View {
        Section {
            FontSizeRangeSliders(fontSizeRange: $fonts.sizeRange, min: min, max: max)
            FontDesignWeightPicker(fonts: $fonts, isRandom: isRandom)
        } header: {
            Text("Font")
        }
    }
}
