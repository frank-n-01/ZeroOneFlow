// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct ContentTypeView: View {
    @Binding var contentType: Contents
    
    var body: some View {
        Section() {
            typePicker
            detailPicker
        } header: {
            Text("Content")
        }
    }
    
    var typePicker: some View {
        Picker(selection: $contentType.type) {
            ForEach(ContentType.allCases) { type in
                Text(type.name)
                    .font(.title3)
                    .tag(type)
            }
        } label: {
            Text("Type")
                .font(.title3)
        }
    }
    
    var detailPicker: some View {
        Group {
            if contentType.type == .number {
                numberPicker
            } else if contentType.type == .language {
                languagePicker
            } else if contentType.type == .symbol {
                symbolPicker
            } else if contentType.type == .custom {
                customTextField
            }
        }
    }
    
    var numberPicker: some View {
        Picker(selection: $contentType.number) {
            ForEach(NumberType.allCases) { number in
                Text(number.name)
                    .font(.title3)
                    .tag(number)
            }
        } label: {
            Text("Number")
                .font(.title3)
        }
    }
    
    var languagePicker: some View {
        Picker(selection: $contentType.language) {
            ForEach(LanguageType.allCases) { language in
                Text(language.name)
                    .font(.title3)
                    .tag(language)
            }
        } label: {
            Text("Language")
                .font(.title3)
        }
    }
    
    var symbolPicker: some View {
        Picker(selection: $contentType.symbol) {
            ForEach(SymbolType.allCases) { symbol in
                Text(symbol.name)
                    .font(.title3)
                    .tag(symbol)
            }
        } label: {
            Text("Symbol")
                .font(.title3)
        }
    }
    
    var customTextField: some View {
        ForEach(0 ..< 2) { i in
            TextField( i == 0 ? "First Content" : "Second Content", text: $contentType.customValue[i])
                .autocapitalization(.none)
        }
    }
}
