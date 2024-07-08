//
//  FigureDynamicLayoutsView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-08.
//

import Foundation
import SwiftUI

struct FigureDynamicLayoutsView: View {

    let figures: [Figure]

    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    var body: some View {
        dynamicLayout {
            ForEach(figures) { figure in
                FigureDynamicLayoutsItemView(figure: figure)
            }
        }
    }

    private var dynamicLayout: AnyLayout {
        dynamicTypeSize.isAccessibilitySize ? AnyLayout(VStackLayout(alignment: .leading)) : AnyLayout(HStackLayout(alignment: .top))
    }
}

struct FigureDynamicLayoutsItemView: View {

    let figure: Figure

    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize

    var body: some View {
        dynamicLayout {
            Image(systemName: figure.systemImage)
                .font(.body)
                .debugBorder(isEnabled: true)

            Text(figure.figureName)
                .font(.body)
                .debugBorder(isEnabled: true)
        }
    }

    private var dynamicLayout: AnyLayout {
        dynamicTypeSize.isAccessibilitySize ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
    }
}
