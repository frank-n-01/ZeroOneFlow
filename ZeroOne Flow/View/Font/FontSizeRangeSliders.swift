// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct FontSizeRangeSliders: View {
    @Binding var fontSizeRange: FontSizeRange
    var min: CGFloat
    var max: CGFloat
    
    var body: some View {
        maxSlider
        minSlider
    }
    
    private var maxSlider: some View {
        HStack {
            Text("Max")
                .font(.title3)
            Slider(value: $fontSizeRange.max, in: fontSizeRange.min...max)
                .padding(.leading, 5)
            Text(String(format: "%.f", fontSizeRange.max))
                .font(.title3)
                .foregroundColor(.gray)
                .frame(width: fontSizeRange.max >= 1000
                       || fontSizeRange.max <= -100 ? 60 : 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
    
    private var minSlider: some View {
        HStack {
            Text("Min")
                .font(.title3)
            Slider(value: $fontSizeRange.min, in: min...fontSizeRange.max)
                .padding(.leading, 10)
            Text(String(format: "%.f", fontSizeRange.min))
                .font(.title3)
                .foregroundColor(.gray)
                .frame(width: fontSizeRange.min >= 1000
                       || fontSizeRange.min <= -100 ? 60 : 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
}
