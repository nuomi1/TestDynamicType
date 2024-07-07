//
//  FigureScaledTextViewController.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-07.
//

import Foundation
import UIKit

class FigureScaledTextViewController: UIViewController {

    let text: String

    private var label: UILabel!

    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // label

        label = UILabel()
        label.text = text
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.debugBorder(isEnabled: true)

        view.addSubview(label)

        setupConstraints()
    }

    private func setupConstraints() {
        // label

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
