// Copyright © 2021-2022 Ni Fu. All rights reserved.

import SwiftUI

struct ToggleWithLabel: View {
    @Binding var value: Bool
    let label: LocalizedStringKey
    var trueImage: String = ""
    var falseImage: String = ""
    var showImage = false
    
    var body: some View {
        Toggle(isOn: $value) {
            if showImage {
                Label(label, systemImage: value ? trueImage : falseImage)
                    .font(CommonStyle.LABEL_FONT)
            } else {
                Text(label)
                    .font(CommonStyle.LABEL_FONT)
            }
        }
    }
}
