// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct PaddingSliderView: View {
    @Binding var padding: Padding
    
    var body: some View {
        Section {
            verticalSlider
            horizontalSlider
        } header: {
            Text("Padding")
        }
    }
    
    private var verticalSlider: some View {
        HStack {
            Image(systemName: "arrow.up.and.down")
                .font(CommonStyle.LABEL_FONT)
                .frame(width: 30)
                .foregroundColor(.gray)
            Slider(value: $padding.vertical, in: padding.min...padding.max)
                .padding(.leading, 10)
            Text(String(format: "%.f", padding.vertical))
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
                .frame(width: 60)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
    
    private var horizontalSlider: some View {
        HStack {
            Image(systemName: "arrow.left.and.right")
                .font(CommonStyle.LABEL_FONT)
                .frame(width: 30)
                .foregroundColor(.gray)
            Slider(value: $padding.horizontal, in: padding.min...padding.max)
                .padding(.leading, 10)
            Text(String(format: "%.f", padding.horizontal))
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
                .frame(width: 60)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
}
