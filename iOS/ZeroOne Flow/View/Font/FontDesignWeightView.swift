// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct FontDesignWeightPicker: View {
    @Binding var fonts: Fonts
    var isRandom: Bool
    
    var body: some View {
        designPicker
        weightPicker
    }
    
    var designPicker: some View {
        Picker(selection: $fonts.design) {
            ForEach(isRandom ? FontDesign.allCases : FontDesign.allCasesWithoutRandom) { design in
                Text(design.name)
                    .font(.system(CommonStyle.LABEL_TEXT_STYLE,
                                  design: design != .random ? design.value : .default))
                    .fontWeight(fonts.weight == .random ? .regular : fonts.weight.value)
                    .tag(design)
            }
        } label: {
            Text("Design")
                .font(CommonStyle.LABEL_FONT)
        }
    }
    
    var weightPicker: some View {
        Picker(selection: $fonts.weight) {
            ForEach(isRandom ? FontWeight.allCases
                    : FontWeight.allCasesWithoutRandom) { weight in
                Text(weight.name)
                    .font(.system(CommonStyle.LABEL_TEXT_STYLE,
                                  design: fonts.design == .random ? .default : fonts.design.value))
                    .fontWeight(weight != .random ? weight.value : .regular)
                    .tag(weight)
            }
        } label: {
            Text("Weight")
                .font(CommonStyle.LABEL_FONT)
        }
    }
}
