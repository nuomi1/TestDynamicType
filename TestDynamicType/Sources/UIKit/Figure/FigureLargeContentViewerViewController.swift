//
//  FigureLargeContentViewerViewController.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-08.
//

import Foundation
import UIKit

class FigureLargeContentViewerViewController: UIViewController {

    private let figures: [Figure]

    private var mainStackView: UIStackView!
    private var itemViews: [FigureLargeContentViewerItemView] = []

    init(figures: [Figure]) {
        self.figures = figures
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupStackView()
        setupConstraints()
    }

    private func setupStackView() {
        // mainStackView

        mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 8

        view.addSubview(mainStackView)

        // itemViews

        itemViews = figures.map { figure in
            let itemView = FigureLargeContentViewerItemView(figure: figure)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapFigureView(_:)))
            itemView.addGestureRecognizer(tapGesture)
            return itemView
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

    @objc
    private func onTapFigureView(_ sender: UITapGestureRecognizer) {
        guard let figureView = sender.view as? FigureLargeContentViewerItemView else {
            assertionFailure()
            return
        }

        let figure = figureView.figure

        let alertController = UIAlertController(title: figure.figureName, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}

extension FigureLargeContentViewerViewController {

    class FigureLargeContentViewerItemView: UIStackView {

        let figure: Figure

        private var imageView: UIImageView!
        private var titleLabel: UILabel!

        init(figure: Figure) {
            self.figure = figure
            super.init(frame: .zero)
            setupStackView()
            setupInteraction()
        }

        @available(*, unavailable)
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupStackView() {
            // self

            axis = .horizontal
            alignment = .center
            spacing = 8

            // imageView

            imageView = UIImageView()
            imageView.image = UIImage(systemName: figure.systemImage)
            imageView.preferredSymbolConfiguration = .init(font: .systemFont(ofSize: 17, weight: .regular))
            imageView.debugBorder(isEnabled: true)

            addArrangedSubview(imageView)

            // titleLabel

            titleLabel = UILabel()
            titleLabel.text = figure.figureName
            titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
            titleLabel.numberOfLines = 0
            titleLabel.debugBorder(isEnabled: true)

            addArrangedSubview(titleLabel)
        }

        private func setupInteraction() {
            addInteraction(UILargeContentViewerInteraction())
            largeContentImage = UIImage(systemName: figure.systemImage)
            largeContentTitle = figure.figureName
            scalesLargeContentImage = true
            showsLargeContentViewer = true
        }
    }
}
