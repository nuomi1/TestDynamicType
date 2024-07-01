//
//  UIKitLabel.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-02.
//

import Foundation
import SwiftUI
import UIKit

struct UIKitLabel: UIViewRepresentable {

    typealias UIViewType = UILabel

    let text: String
    let font: UIFont

    func makeUIView(context: Context) -> UIViewType {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
        uiView.font = font
    }

    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIViewType, context: Context) -> CGSize? {
        uiView.sizeThatFits(proposal.replacingUnspecifiedDimensions())
    }
}
