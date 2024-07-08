//
//  FigureSymbolsView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-08.
//

import Foundation
import SwiftUI

struct FigureSymbolsView: View {

    let figures: [Figure]

    var body: some View {
        List(figures) { figure in
            FigureSymbolsItemView(figure: figure)
        }
    }
}

struct FigureSymbolsItemView: View {

    let figure: Figure

    var body: some View {
        Label {
            Text(figure.figureName)
                .font(.body)
                .debugBorder(isEnabled: true)
        } icon: {
            Image(systemName: figure.systemImage)
                .font(.body)
                .debugBorder(isEnabled: true)
        }
    }
}
