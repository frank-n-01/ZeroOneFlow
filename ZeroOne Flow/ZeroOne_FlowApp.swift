// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

@main
struct ZeroOne_FlowApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var modeUD = ModeUserDefaults()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(modeUD)
        }
    }
}
