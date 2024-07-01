//
//  UIKitTripDetailView+RoundedLabel.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-01.
//

import Foundation
import UIKit

extension UIKitTripDetailView.UIKitTripDetailViewController {

    class RoundedLabel: UILabel {

        var contentInsets: NSDirectionalEdgeInsets = .zero {
            didSet {
                invalidateIntrinsicContentSize()
                setNeedsLayout()
            }
        }

        private func toUIEdgeInsets() -> UIEdgeInsets {
            .init(
                top: contentInsets.top,
                left: contentInsets.leading,
                bottom: contentInsets.bottom,
                right: contentInsets.trailing
            )
        }

        override var intrinsicContentSize: CGSize {
            var size = super.intrinsicContentSize
            size.width += contentInsets.leading + contentInsets.trailing
            size.height += contentInsets.top + contentInsets.bottom
            return size
        }

        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: toUIEdgeInsets()))
        }
    }
}
