// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct FontRangeView: View {
    @Binding var fonts: Fonts
    var min: CGFloat
    var max: CGFloat
    var isRandom: Bool
    
    var body: some View {
        Section {
            FontSizeRangeSliders(range: $fonts.sizeRange, min: min, max: max)
            FontDesignWeightPicker(fonts: $fonts, isRandom: isRandom)
        } header: {
            Text("Font")
        }
    }
}
