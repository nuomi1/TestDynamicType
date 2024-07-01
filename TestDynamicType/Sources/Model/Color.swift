//
//  Color.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftUI

struct CodableColor: Codable, Hashable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double = 1

    var color: Color {
        Color(
            red: red,
            green: green,
            blue: blue,
            opacity: opacity
        )
    }
}

extension Color.Resolved {
    var resolvedCodableColor: CodableColor {
        CodableColor(
            red: Double(red),
            green: Double(green),
            blue: Double(blue),
            opacity: Double(opacity)
        )
    }
}

extension Color {
    var primaryMix: Color {
        mix(with: .primary, by: 0.15)
    }
}
