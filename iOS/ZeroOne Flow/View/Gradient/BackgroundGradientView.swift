// Copyright © 2021 Ni Fu. All rights reserved.

import SwiftUI

struct BackgroundGradientView: View {
    @Binding var colors: Colors
    @Binding var gradient: RandomGradient
    
    var body: some View {
        Group {
            if colors.bgRandom {
                switch gradient.type {
                case .radial:
                    radialGradient
                case .linear:
                    linearGradient
                case .angular:
                    angularGradient
                case .elliptical:
                    ellipticalGradient
                }
            } else {
                colors.bg
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private var radialGradient: some View {
        RadialGradient(gradient: Gradient(colors: [gradient.startColor, gradient.endColor]),
                       center: .center, startRadius: gradient.startRadius,
                       endRadius: gradient.endRadius)
    }
    
    private var linearGradient: some View {
        LinearGradient(gradient: Gradient(colors: [gradient.startColor, gradient.endColor]),
                       startPoint: gradient.startPoint, endPoint: gradient.endPoint)
    }
    
    private var angularGradient: some View {
        AngularGradient(gradient: Gradient(colors: [gradient.startColor, gradient.endColor]),
                        center: gradient.center, angle: .init(degrees: gradient.angle))
    }
    
    private var ellipticalGradient: some View {
        EllipticalGradient(gradient: Gradient(colors: [gradient.startColor, gradient.endColor]),
                           center: gradient.center, startRadiusFraction: CGFloat.random(in: 0...1),
                           endRadiusFraction: CGFloat.random(in: 0...1))
    }
}
