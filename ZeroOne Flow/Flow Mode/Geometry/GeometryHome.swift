// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct GeometryHome: View {
    @ObservedObject var geometry = GeometryViewModel()

    var body: some View {
        Section {
            ShapePicker(shape: $geometry.shape)
            CGFloatSlider(value: $geometry.fonts.size, min: 0.1, max: 100, image: "lineweight", format: geometry.fonts.size < 10 ? "%.1f" : "%.0f")
            ToggleWithLabel(value: $geometry.isFill, label: "Fill")
        } header: {
            Text("Shape")
        }
        
        ColorView(colors: $geometry.colors, random: false)
        
        Section {
            SliderWithSingleImage(value: $geometry.scale, min: 1, max: 50, image: "square.3.stack.3d", format: "%.0f")
        } header: {
            Text("Scale")
        }
        
        Section {
            SandwichedImageSlider(interval: $geometry.interval, min: 0.01, max: 1.0)
        } header: {
            Text("Speed")
        }
    }
}

struct ShapePicker: View {
    @Binding var shape: Shapes
    
    var body: some View {
        Picker(selection: $shape) {
            ForEach(Shapes.allCases) { shape in
                Text(shape.name)
                    .font(.title3)
                    .tag(shape)
            }
        } label: {
            Text("Type")
                .font(.title3)
        }
    }
}

enum Shapes: Int, CaseIterable, Identifiable {
    case triangle
    case line
    case rectangle
    case ellipse
    case curve
    
    var id: UUID {
        return UUID()
    }
    
    var name: LocalizedStringKey {
        switch self {
        case .triangle:
            return "Triangle"
        case .line:
            return "Line"
        case .rectangle:
            return "Rectangle"
        case .ellipse:
            return "Ellipse"
        case .curve:
            return "Curve"
        }
    }
}
