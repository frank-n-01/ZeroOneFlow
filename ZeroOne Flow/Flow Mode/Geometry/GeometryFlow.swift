// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct GeometryFlow: View {
    @ObservedObject var geometry: GeometryViewModel
    @State private var loop = 0
    
    var body: some View {
        ZStack {
            geometry.colors.bg.edgesIgnoringSafeArea(.all)
            
            ForEach(0 ..< loop, id: \.self) { _ in
                GeometryParts(geometry: geometry)
            }
        }
        .onAppear {
            loop = Int(geometry.scale)
        }
    }
}

/// Draw the shapes using path objects.
struct GeometryParts: View {
    @ObservedObject var geometry: GeometryViewModel
    @State private var points = GeometryPoints()
    @State private var rotation3D = Rotation3D()
    
    var body: some View {
        GeometryReader { proxy in
            Group {
                if geometry.isFill && geometry.shape != .line {
                    path.fill(geometry.colors.txt)
                } else {
                    path.stroke(geometry.colors.txt, lineWidth: geometry.fonts.size)
                }
            }
            .onReceive(Timer.publish(every: geometry.isFlowing ? geometry.interval : 100, on: .current, in: .common).autoconnect()) { _ in
                guard geometry.isFlowing else { return }
                
                points.random(in: proxy)
                rotation3D.random()
            }
            .rotation3DEffect(.degrees(rotation3D.angle),
                              axis: (x: rotation3D.axis.x, y: rotation3D.axis.y, z: rotation3D.axis.z),
                              anchorZ: rotation3D.anchorZ,
                              perspective: rotation3D.perspective)
        }
    }
    
    /// The path of the selected shape.
    var path: Path {
        switch geometry.shape {
        case .triangle:
            return triangle
        case .line:
            return line
        case .rectangle:
            return rectangle
        case .ellipse:
            return ellipse
        case .curve:
            return curve
        }
    }
    
    // MARK: - Triangle

    var triangle: Path {
        Path { path in
            path.move(to: points.first)
            path.addLine(to: points.second)
            path.addLine(to: points.third)
            path.addLine(to: points.first)
            path.closeSubpath()
        }
    }
    
    // MARK: - Line
    
    var line: Path {
        Path { path in
            path.move(to: points.first)
            path.addLine(to: points.second)
        }
    }
    
    // MARK: - Rectangle
    
    var rectangle: Path {
        Path { path in
            path.addRect(points.rect)
        }
    }
    
    // MARK: - Ellipse
    
    var ellipse: Path {
        Path { path in
            path.addEllipse(in: points.rect)
        }
    }
    
    // MARK: - Curve
    
    var curve: Path {
        Path { path in
            path.move(to: points.first)
            path.addQuadCurve(to: points.second, control: points.third)
        }
    }
}

/// The point properties to draw the shapes using path objects.
struct GeometryPoints {
    var first: CGPoint = .zero
    var second: CGPoint = .zero
    var third: CGPoint = .zero
    var rect: CGRect = .zero
    
    mutating func random(in geometry: GeometryProxy) {
        let width = geometry.size.width
        let height = geometry.size.height
        first = CGPoint(x: CGFloat.random(in: 0...width), y: CGFloat.random(in: 0...height))
        second = CGPoint(x: CGFloat.random(in: 0...width), y: CGFloat.random(in: 0...height))
        third = CGPoint(x: CGFloat.random(in: 0...width), y: CGFloat.random(in: 0...height))
        rect = CGRect(x: first.x - width / 4, y: first.y - height / 4, width: second.x, height: second.y)
    }
}
