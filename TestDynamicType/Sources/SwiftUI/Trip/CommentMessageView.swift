//
//  CommentMessageView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-30.
//

import Foundation
import SwiftUI

struct CommentMessageView<Icon: View, Title: View>: View {

    let configuration: Configuration

    init(
        @ViewBuilder icon: () -> Icon,
        @ViewBuilder title: () -> Title
    ) {
        configuration = Configuration(icon: icon(), title: title())
    }

    var body: some View {
        HStack {
            configuration.icon
                .frame(width: 10, height: 10)
                .foregroundStyle(.blue)
                .padding(.leading, 10)

            configuration.title
                .modifier(CommentModifier(style: .quaternary))
        }
    }
}

extension CommentMessageView {

    struct Configuration {
        var icon: Icon
        var title: Title
    }
}

struct CommentModifier<Style: ShapeStyle>: ViewModifier {

    let style: Style

    func body(content: Content) -> some View {
        content
            .padding(.vertical, 3)
            .padding(.horizontal, 6)
            .background {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(style)
            }
            .frame(width: .infinity, height: .infinity)
            .padding(.top, 3)
    }
}
