// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct SpeedSlider: View {
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
        .font(CommonStyle.LABEL_FONT)
        .foregroundColor(.gray)
    }
}
