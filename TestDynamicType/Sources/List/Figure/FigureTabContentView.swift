//
//  FigureTabContentView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-07.
//

import Foundation
import SwiftUI

struct FigureTabContentView: View {

    typealias Configuration = TabContentViewConfiguration

    private let configuration: Configuration

    private let examples = Example.allCases
    @State
    private var selectedExample: Example?

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    var body: some View {
        TabContentView(configuration: configuration) {
            FigureListView(examples: examples, selectedExample: $selectedExample)
        } detail: {
            if let selectedExample {
                detail(example: selectedExample)
                    .navigationTitle(selectedExample.rawValue)
            } else {
                Text("Select a example")
                    .navigationTitle("Examples")
            }
        }
    }

    @ViewBuilder
    private func detail(example: Example) -> some View {
        switch example {
        case .scaledText:
            scaledTextView
        case .dynamicLayouts:
            dynamicLayoutsView
        case .symbols:
            symbolsView
        }
    }

    @ViewBuilder
    private var scaledTextView: some View {
        let text = String(repeating: "Hello, World! ", count: 10)

        switch configuration {
        case Constants.Tab.swiftUI:
            FigureScaledTextView(text: text)
        case Constants.Tab.uiKit:
            AnyUIRepresentableViewController(configuration: .init(
                makeUIViewController: { _ in
                    FigureScaledTextViewController(text: text)
                },
                updateUIViewController: { _, _ in
                    // no-op
                }
            ))
        default:
            fatalError()
        }
    }

    @ViewBuilder
    private var dynamicLayoutsView: some View {
        let figures = Figure.allCases

        switch configuration {
        case Constants.Tab.swiftUI:
            FigureDynamicLayoutsView(figures: figures)
        case Constants.Tab.uiKit:
            AnyUIRepresentableViewController(configuration: .init(
                makeUIViewController: { _ in
                    FigureDynamicLayoutsViewController(figures: figures)
                },
                updateUIViewController: { _, _ in
                    // no-op
                }
            ))
        default:
            fatalError()
        }
    }

    @ViewBuilder
    private var symbolsView: some View {
        let figures = Figure.allCases

        switch configuration {
        case Constants.Tab.swiftUI:
            FigureSymbolsView(figures: figures)
        case Constants.Tab.uiKit:
            AnyUIRepresentableViewController(configuration: .init(
                makeUIViewController: { _ in
                    FigureSymbolsViewController(figures: figures)
                },
                updateUIViewController: { _, _ in
                    // no-op
                }
            ))
        default:
            fatalError()
        }
    }
}
