//
//  FigureListView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-07.
//

import Foundation
import SwiftUI

struct FigureListView: View {

    let examples: [Example]
    @Binding
    var selectedExample: Example?

    var body: some View {
        List(selection: $selectedExample) {
            ForEach(examples, id: \.self) { example in
                Label {
                    Text(example.rawValue)
                        .bold()
                } icon: {
                    Image(systemName: example.systemImage)
                }
            }
        }
    }
}
