//
//  CommentLabeledContentStyle.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-30.
//

import Foundation
import SwiftUI

struct CommentLabeledContentStyle: LabeledContentStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack {
                configuration.content
            }

            configuration.label
                .textCase(.uppercase)
                .font(.caption)
                .fontWeight(.bold)
                .padding(.leading, 32)
        }
    }
}
