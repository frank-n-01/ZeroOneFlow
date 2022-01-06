// Copyright © 2022 Ni Fu. All rights reserved.

import SwiftUI

class ChatViewModel: FlowModeViewModel {
    
    var ud = ChatUserDefaults(Mode.chat.key)
    
    static let FONT = Fonts(size: 18,
                            design: .monospaced,
                            weight: .regular,
                            min: 10, max: 100)
    
    init() {
        super.init(ud: ud, fonts: Self.FONT)
    }
}
