// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct ContentTypeView: View {
    @Binding var contents: Contents
    
    var body: some View {
        Section() {
            typePicker
            detailPicker
        } header: {
            Text("Content")
        }
    }
    
    var typePicker: some View {
        Picker(selection: $contents.type) {
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
            switch contents.type {
            case .number:
                numberPicker
            case .language:
                languagePicker
            case .symbol:
                symbolPicker
            case .custom:
                customTextField
            case .code:
                codePicker
            }
        }
    }
    
    var numberPicker: some View {
        Picker(selection: $contents.number) {
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
        Picker(selection: $contents.language) {
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
        Picker(selection: $contents.symbol) {
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
            TextField( i == 0 ? "First Content" : "Second Content", text: $contents.customValue[i])
                .autocapitalization(.none)
        }
    }
    
    var codePicker: some View {
        Picker(selection: $contents.code) {
            ForEach(CodeType.allCases) { code in
                Text(code.name)
                    .font(.title3)
                    .tag(code)
            }
        } label: {
            Text("Code")
                .font(.title3)
        }
    }
}
