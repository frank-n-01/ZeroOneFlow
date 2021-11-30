// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct CoreDataStyleList: View {
    @ObservedObject var viewModel: FlowModeViewModel
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: Mode.allCases[ModeUserDefaults.currentMode].entity,
        sortDescriptors: [NSSortDescriptor(keyPath: \FlowMode.date, ascending: false)]
    ) var styles: FetchedResults<FlowMode>
    
    var body: some View {
        List {
            Section {
                SaveStyleView(saveCoreData: saveCoreData)
            }
            
            Section {
                styleRows
            }
        }
        .toolbar {
            EditButton()
        }
        .listStyle(.insetGrouped)
        .navigationTitle("My Styles")
    }
    
    var styleRows: some View {
        ForEach(styles.indices, id: \.self) { i in
            HStack {
                Group {
                    if styles[i].name ?? "" == "unnamed" {
                        Text(LocalizedStringKey(styles[i].name ?? ""))
                    } else {
                        Text(styles[i].name ?? "")
                    }
                }
                .font(.title3)
                
                Button(action: { applyCoreData(index: i) }) {
                    Spacer()
                }
            }
        }
        .onDelete(perform: remove)
        .onMove(perform: move)
    }
    
    func saveCoreData(name: String) {
        viewModel.saveCoreData(context, name)
    }
    
    func applyCoreData(index: Int) {
        viewModel.applyCoreData(context, styles[index])
    }
    
    private func remove(at offsets: IndexSet) {
        guard !styles.isEmpty else { return }
        
        for index in offsets {
            context.delete(styles[index])
        }
        
        if context.hasChanges {
            try? context.save()
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        guard let source = source.first else { return }
        
        let tmp = styles[source].date
        
        if source < destination {
            styles[source].date = styles[destination - 1].date
            
            for i in (source + 1...destination - 1).reversed() {
                if i == source + 1 {
                    styles[i].date = tmp
                } else {
                    styles[i].date = styles[i - 1].date
                }
            }
        } else if source > destination {
            styles[source].date = styles[destination].date
            
            for i in destination...source - 1 {
                if i == source - 1 {
                    styles[i].date = tmp
                } else {
                    styles[i].date = styles[i + 1].date
                }
            }
        }
        
        if context.hasChanges {
            try? context.save()
        }
    }
}
