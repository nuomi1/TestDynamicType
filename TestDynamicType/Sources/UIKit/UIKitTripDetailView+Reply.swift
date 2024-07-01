//
//  UIKitTripDetailView+Reply.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-01.
//

import Foundation
import UIKit

extension UIKitTripDetailView.UIKitTripDetailViewController {

    class ReplyView: UIView, UIContentView {

        var configuration: any UIContentConfiguration {
            didSet {
                updateContentConfiguration(configuration as! ContentConfiguration)
            }
        }

        private let replyLabel = RoundedLabel()

        init(configuration: ContentConfiguration) {
            self.configuration = configuration
            super.init(frame: .zero)
            prepare()
            updateContentConfiguration(configuration)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func prepare() {
            // replyLabel

            replyLabel.backgroundColor = .quaternaryLabel
            replyLabel.contentInsets = .init(top: 3, leading: 6, bottom: 3, trailing: 6)
            replyLabel.layer.cornerRadius = 6
            replyLabel.layer.masksToBounds = true

            replyLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(replyLabel)
            NSLayoutConstraint.activate([
                replyLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                replyLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 8 + 10 + 8 + 4),
                replyLabel.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor, constant: -8),
                replyLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            ])
        }

        private func updateContentConfiguration(_ configuration: ContentConfiguration) {
            // replyLabel

            replyLabel.text = configuration.reply.message
        }
    }
}

extension UIKitTripDetailView.UIKitTripDetailViewController.ReplyView {

    struct ContentConfiguration: UIContentConfiguration {

        let reply: Comment.Reply

        func makeContentView() -> any UIView & UIContentView {
            let contentView = UIKitTripDetailView.UIKitTripDetailViewController.ReplyView(configuration: self)
            return contentView
        }

        func updated(for state: any UIConfigurationState) -> ContentConfiguration {
            self
        }
    }
}
