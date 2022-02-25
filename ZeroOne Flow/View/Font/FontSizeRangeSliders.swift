// Copyright © 2021 Ni Fu. All rights reserved.

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
                .font(.title3)
            Slider(value: $range.max, in: range.min...max)
                .padding(.leading, 5)
            Text(String(format: "%.f", range.max))
                .font(.title3)
                .foregroundColor(.gray)
                .frame(width: range.max >= 1000
                       || range.max <= -100 ? 60 : 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onAppear {
            if range.min > max {
                range.min = max
            }
        }
    }
    
    private var minSlider: some View {
        HStack {
            Text("Min")
                .font(.title3)
            Slider(value: $range.min, in: min...range.max)
                .padding(.leading, 10)
            Text(String(format: "%.f", range.min))
                .font(.title3)
                .foregroundColor(.gray)
                .frame(width: range.min >= 1000
                       || range.min <= -100 ? 60 : 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onAppear {
            if range.max < min {
                range.max = min
            }
        }
    }
}
