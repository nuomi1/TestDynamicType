//
//  Example.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-07.
//

import Foundation

enum Example: String, CaseIterable, Hashable, Identifiable, RawRepresentable {

    typealias ID = Self

    case scaledText = "Scaled Text"
    case dynamicLayouts = "Dynamic Layouts"

    var id: ID {
        self
    }

    var systemImage: String {
        switch self {
        case .scaledText:
            return "textformat.size"
        case .dynamicLayouts:
            return "square.resize"
        }
    }
}
