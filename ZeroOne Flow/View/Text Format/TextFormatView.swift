// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct TextFormatView: View {
    @Binding var format: TextFormat
    let min: Double
    let max: Double
    var header: LocalizedStringKey
    var image: String
    
    var body: some View {
        Section {
            slider
            toggle
        } header: {
            Text(header)
        }
    }
    
    private var toggle: some View {
        Toggle(isOn: $format.isOn) {
            Text("Activate")
                .font(CommonStyle.LABEL_FONT)
        }
    }
    
    private var slider: some View {
        HStack(spacing: 10) {
            Image(systemName: image)
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
            Slider(value: $format.value, in: min...max)
            Text(String(format: "%.0f", format.value))
                .font(CommonStyle.LABEL_FONT)
                .foregroundColor(.gray)
                .frame(width: 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
}
