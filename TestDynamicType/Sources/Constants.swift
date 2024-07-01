//
//  Constants.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-26.
//

import Foundation
import SwiftUI
import UIKit

enum Constants {

    enum Tab {
        static let swiftUI = TabContentViewConfiguration(tabTitle: "SwiftUI", tabIcon: "sun.max", navigationTitle: "SwiftUI Dynamic Type")
        static let uiKit = TabContentViewConfiguration(tabTitle: "UIKit", tabIcon: "moon", navigationTitle: "UIKit Dynamic Type")
    }

    enum Font {
        static var swiftUI: [SwiftUI.Font] { [
            // .extraLargeTitle,
            // .extraLargeTitle2,
            .largeTitle,
            .title,
            .title2,
            .title3,
            .headline,
            .subheadline,
            .body,
            .callout,
            .caption,
            .caption2,
            .footnote,
        ] }

        static var uiKit: [UIFont] { [
            .extraLargeTitle,
            .extraLargeTitle2,
            .largeTitle,
            .title1,
            .title2,
            .title3,
            .headline,
            .subheadline,
            .body,
            .callout,
            .caption1,
            .caption2,
            .footnote,
        ].map { UIFont.preferredFont(forTextStyle: $0) }}
    }
}
