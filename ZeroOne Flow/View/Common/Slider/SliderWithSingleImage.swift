// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct SliderWithSingleImage: View {
    @Binding var value: Double
    var min: Double
    var max: Double
    var image: String
    var format: String = "%.0f"
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.title3)
                .foregroundColor(.gray)
            Slider(value: $value, in: min...max)
                .padding(.leading, 10)
            Text(String(format: format, value))
                .font(.title3)
                .foregroundColor(.gray)
                .frame(width: value >= 1000 || value <= -100 ? 60 : 50)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
    }
}
