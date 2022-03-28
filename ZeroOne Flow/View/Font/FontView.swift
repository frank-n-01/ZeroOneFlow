// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct FontView: View {
    @Binding var fonts: Fonts
    var minSize: CGFloat
    var maxSize: CGFloat
    var isRandom: Bool = false
    
    var body: some View {
        Section {
            CGFloatSlider(value: $fonts.size, min: minSize, max: maxSize)
            FontDesignWeightPicker(fonts: $fonts, isRandom: isRandom)
        } header: {
            Text("Font")
        }
    }
}
