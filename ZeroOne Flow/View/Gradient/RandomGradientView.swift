// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct RandomGradientView: View {
    @Binding var colors: Colors
    @Binding var type: GradientType
    
    var body: some View {
        typePicker
        activateToggle
    }
    
    private var typePicker: some View {
        Picker(selection: $type) {
            ForEach(0 ..< GradientType.allCases.count, id: \.self) { index in
                Text(GradientType.allCases[index].name)
                    .tag(GradientType.allCases[index])
                    .font(CommonStyle.LABEL_FONT)
            }
        } label: {
            Text("Type")
                .font(CommonStyle.LABEL_FONT)
        }
    }
    
    private var activateToggle: some View {
        Toggle(isOn: $colors.bgRandom) {
            Text("Activate")
                .font(CommonStyle.LABEL_FONT)
        }
    }
}
