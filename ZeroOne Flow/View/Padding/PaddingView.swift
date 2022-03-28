// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct PaddingView: View {
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
            Image(systemName: "v.square")
                .font(CommonStyle.LABEL_FONT)
            Slider(value: $padding.ver, in: padding.min...padding.max)
                .padding(.leading, 10)
            Text(String(format: "%.f", padding.ver))
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
                .frame(width: 60)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
    
    private var horizontalSlider: some View {
        HStack {
            Image(systemName: "h.square")
                .font(CommonStyle.LABEL_FONT)
            Slider(value: $padding.hor, in: padding.min...padding.max)
                .padding(.leading, 10)
            Text(String(format: "%.f", padding.hor))
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
                .frame(width: 60)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
}
