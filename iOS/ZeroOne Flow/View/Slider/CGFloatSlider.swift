// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct CGFloatSlider: View {
    @Binding var value: CGFloat
    let min: CGFloat
    let max: CGFloat
    var image: String = "textformat.size"
    var format: String = "%.f"
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
            Slider(value: $value, in: min...max)
                .padding(.leading, 10)
            Text(String(format: format, value))
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
                .frame(width: value >= 1000 || value <= -100 ? 60 : 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
}
