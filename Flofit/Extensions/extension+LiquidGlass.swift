//
//  extension+LiquidGlass.swift
//  LiMaChallenge3
//
//  Created by Juan Fausta Pringadi on 13/06/26.
//

import SwiftUI

import SwiftUI

struct LiquidGlassModifier: ViewModifier {
    var color: Color
    var radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .glassEffect(
                .regular.tint(color).interactive(), in: RoundedRectangle(cornerRadius: radius)
            )
    }
}

extension View {
    func liquidGlass(color: Color, radius: CGFloat) -> some View {
        self.modifier(LiquidGlassModifier(color: color, radius: radius))
    }
    
    func liquidGlass<S: ShapeStyle>(gradient: S, radius: CGFloat, tintColor: Color = .clear) -> some View {
            self
                // Pasang gradien di layer paling bawah sesuai radius kartu
                .background(gradient, in: RoundedRectangle(cornerRadius: radius))
                // Lapisi dengan efek glass transparan (.clear) di atasnya agar tekstur glossynya tetap muncul
                .modifier(LiquidGlassModifier(color: tintColor, radius: radius))
        }
}
