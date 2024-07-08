//
//  FigureDynamicLayoutsViewController.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-08.
//

import Combine
import Foundation
import UIKit

class FigureDynamicLayoutsViewController: UIViewController {

    let figures: [Figure]

    private var mainStackView: UIStackView!
    private var itemViews: [FigureDynamicLayoutsItemView] = []
    private var cancellables: Set<AnyCancellable> = []

    init(figures: [Figure]) {
        self.figures = figures
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStackView()
        setupConstraints()

        NotificationCenter.default
            .publisher(for: UIContentSizeCategory.didChangeNotification)
            .sink { [weak self] notification in
                self?.sizeCategoryDidChange(notification)
            }
            .store(in: &cancellables)
    }

    private func setupStackView() {
        let sizeCategory = UITraitCollection.current.preferredContentSizeCategory

        // mainStackView

        mainStackView = UIStackView()
        mainStackView.axis = sizeCategory.isAccessibilityCategory ? .vertical : .horizontal
        mainStackView.alignment = sizeCategory.isAccessibilityCategory ? .leading : .center
        mainStackView.spacing = 8

        view.addSubview(mainStackView)

        // itemViews

        itemViews = figures.map { figure in
            FigureDynamicLayoutsItemView(figure: figure)
        }

        for itemView in itemViews {
            mainStackView.addArrangedSubview(itemView)
        }
    }

    private func setupConstraints() {
        // mainStackView

        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func sizeCategoryDidChange(_ notification: Notification) {
        let sizeCategory = notification.userInfo![UIContentSizeCategory.newValueUserInfoKey]! as! UIContentSizeCategory

        // mainStackView

        mainStackView.axis = sizeCategory.isAccessibilityCategory ? .vertical : .horizontal
        mainStackView.alignment = sizeCategory.isAccessibilityCategory ? .leading : .center
    }
}

extension FigureDynamicLayoutsViewController {

    class FigureDynamicLayoutsItemView: UIStackView {

        let figure: Figure

        private var imageView: UIImageView!
        private var titleLabel: UILabel!
        private var cancellables: Set<AnyCancellable> = []

        init(figure: Figure) {
            self.figure = figure
            super.init(frame: .zero)
            setupStackView()

            NotificationCenter.default
                .publisher(for: UIContentSizeCategory.didChangeNotification)
                .sink { [weak self] notification in
                    self?.sizeCategoryDidChange(notification)
                }
                .store(in: &cancellables)
        }

        @available(*, unavailable)
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupStackView() {
            let sizeCategory = UITraitCollection.current.preferredContentSizeCategory

            // self

            axis = sizeCategory.isAccessibilityCategory ? .horizontal : .vertical
            alignment = .center
            spacing = 8

            // imageView

            imageView = UIImageView()
            imageView.image = UIImage(systemName: figure.systemImage)
            imageView.preferredSymbolConfiguration = .init(font: .preferredFont(forTextStyle: .body))
            imageView.debugBorder(isEnabled: true)

            addArrangedSubview(imageView)

            // titleLabel

            titleLabel = UILabel()
            titleLabel.text = figure.figureName
            titleLabel.adjustsFontForContentSizeCategory = true
            titleLabel.font = .preferredFont(forTextStyle: .body)
            titleLabel.numberOfLines = 0
            titleLabel.debugBorder(isEnabled: true)

            addArrangedSubview(titleLabel)
        }

        private func sizeCategoryDidChange(_ notification: Notification) {
            let sizeCategory = notification.userInfo![UIContentSizeCategory.newValueUserInfoKey]! as! UIContentSizeCategory

            // self

            axis = sizeCategory.isAccessibilityCategory ? .horizontal : .vertical
        }
    }
}
