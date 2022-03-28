// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct FontSizeRangeSliders: View {
    @Binding var range: FontSizeRange
    var min: CGFloat
    var max: CGFloat
    
    var body: some View {
        maxSlider
        minSlider
    }
    
    private var maxSlider: some View {
        HStack {
            Text("Max")
                .font(CommonStyle.LABEL_FONT)
            Slider(value: $range.max, in: range.min...max)
                .padding(.leading, 5)
            Text(String(format: "%.f", range.max))
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
                .frame(width: range.max >= 1000 || range.max <= -100 ? 60 : 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
    
    private var minSlider: some View {
        HStack {
            Text("Min")
                .font(CommonStyle.LABEL_FONT)
            Slider(value: $range.min, in: min...range.max)
                .padding(.leading, 10)
            Text(String(format: "%.f", range.min))
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
                .frame(width: range.min >= 1000 || range.min <= -100 ? 60 : 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
}
