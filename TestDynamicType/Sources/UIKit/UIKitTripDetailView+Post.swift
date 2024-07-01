//
//  UIKitTripDetailView+Post.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-30.
//

import Foundation
import UIKit

extension UIKitTripDetailView.UIKitTripDetailViewController {

    class PostView: UIView, UIContentView {

        var configuration: any UIContentConfiguration {
            didSet {
                updateContentConfiguration(configuration as! ContentConfiguration)
            }
        }

        private let cardView = UIView()
        private let stackView = UIStackView()
        private let imageView = UIImageView()
        private let bottomView = UIView()
        private let bottomStackView = UIStackView()
        private let dateLabel = UILabel()
        private let messageLabel = UILabel()
        private let divider = UIView()

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
            // cardView

            cardView.layer.shadowRadius = 10
            cardView.layer.shadowOpacity = 0.5

            cardView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(cardView)
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
                cardView.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 8),
                cardView.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: -8),
            ])

            // stackView

            stackView.axis = .vertical

            stackView.translatesAutoresizingMaskIntoConstraints = false
            cardView.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: cardView.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            ])

            // imageView

            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 10
            imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

            stackView.addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            ])

            // bottomView

            bottomView.layer.cornerRadius = 10
            bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            stackView.addArrangedSubview(bottomView)

            // bottomStackView

            bottomStackView.axis = .vertical
            bottomStackView.spacing = 4

            bottomStackView.translatesAutoresizingMaskIntoConstraints = false
            bottomView.addSubview(bottomStackView)
            NSLayoutConstraint.activate([
                bottomStackView.topAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.topAnchor, constant: 8),
                bottomStackView.leadingAnchor.constraint(equalTo: bottomView.readableContentGuide.leadingAnchor, constant: 8),
                bottomStackView.trailingAnchor.constraint(equalTo: bottomView.readableContentGuide.trailingAnchor, constant: -8),
                bottomStackView.bottomAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.bottomAnchor, constant: -8),
            ])

            // dateLabel

            dateLabel.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold))
            dateLabel.textColor = .white

            bottomStackView.addArrangedSubview(dateLabel)

            // messageLabel

            messageLabel.textColor = .white

            bottomStackView.addArrangedSubview(messageLabel)

            // divider

            divider.backgroundColor = .separator

            divider.translatesAutoresizingMaskIntoConstraints = false
            addSubview(divider)
            NSLayoutConstraint.activate([
                divider.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 12),
                divider.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                divider.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                divider.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -8),
                divider.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale),
            ])
        }

        private func updateContentConfiguration(_ configuration: ContentConfiguration) {
            // imageView

            imageView.image = UIImage(named: configuration.trip.image)

            // bottomView

            bottomView.backgroundColor = UIColor(configuration.trip.color.color.primaryMix)

            // dateLabel

            dateLabel.text = configuration.trip.date.formatted(.dateTime.weekday(.wide)).uppercased()

            // messageLabel

            messageLabel.text = configuration.trip.message
        }
    }
}

extension UIKitTripDetailView.UIKitTripDetailViewController.PostView {

    struct ContentConfiguration: UIContentConfiguration {

        let trip: Trip

        func makeContentView() -> any UIView & UIContentView {
            let contentView = UIKitTripDetailView.UIKitTripDetailViewController.PostView(configuration: self)
            return contentView
        }

        func updated(for state: any UIConfigurationState) -> ContentConfiguration {
            self
        }
    }
}
