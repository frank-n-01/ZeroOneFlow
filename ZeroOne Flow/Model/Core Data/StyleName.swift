// Copyright © 2021 Ni Fu. All rights reserved.

import Foundation

class StyleName: ObservableObject {
    static let MAX_LENGTH = 100
    
    @Published var name: String = "" {
        didSet {
            if name.count > Self.MAX_LENGTH {
                name = String(name.prefix(Self.MAX_LENGTH))
            }
        }
    }
}
