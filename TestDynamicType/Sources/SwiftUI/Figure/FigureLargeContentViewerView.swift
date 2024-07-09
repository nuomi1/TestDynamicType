//
//  FigureLargeContentViewerView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-08.
//

import Foundation
import SwiftUI

struct FigureLargeContentViewerView: View {

    let figures: [Figure]

    @State
    private var selectedFigure: Figure?

    var body: some View {
        HStack {
            ForEach(figures) { figure in
                FigureLargeContentViewerItemView(figure: figure)
                    .onTapGesture {
                        selectedFigure = figure
                    }
            }
        }
        .sheet(item: $selectedFigure) { figure in
            FigureLargeContentViewerItemView(figure: figure)
        }
    }
}

struct FigureLargeContentViewerItemView: View {

    let figure: Figure

    var body: some View {
        Label {
            Text(figure.figureName)
                .font(.system(size: 17, weight: .regular))
                .debugBorder(isEnabled: true)
        } icon: {
            Image(systemName: figure.systemImage)
                .font(.system(size: 17, weight: .regular))
                .debugBorder(isEnabled: true)
        }
        .accessibilityShowsLargeContentViewer {
            Label(figure.figureName, systemImage: figure.systemImage)
        }
    }
}
