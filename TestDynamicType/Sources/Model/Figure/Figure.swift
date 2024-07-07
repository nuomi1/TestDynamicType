//
//  Figure.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-07.
//

import Foundation

struct Figure: CaseIterable, Hashable, Identifiable {

    typealias ID = String

    var figureName: String
    var systemImage: String

    var id: String {
        "\(systemImage) - \(figureName)"
    }

    static var allCases: [Figure] { [
        .init(figureName: "Standing Figure", systemImage: "figure.stand"),
        .init(figureName: "Rolling Figure", systemImage: "figure.roll"),
        .init(figureName: "Waving Figure", systemImage: "figure.wave"),
        .init(figureName: "Walking Figure", systemImage: "figure.walk"),
    ] }
}
