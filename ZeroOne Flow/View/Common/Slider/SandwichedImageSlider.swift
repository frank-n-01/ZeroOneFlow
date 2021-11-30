// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct SandwichedImageSlider: View {
    @Binding var interval: Double
    var min: Double
    var max: Double
    var firstImage = "hare.fill"
    var secondImage = "tortoise.fill"
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: firstImage)
            Slider(value: $interval, in: min...max)
            Image(systemName: secondImage)
        }
        .font(.title3)
        .foregroundColor(.gray)
    }
}
