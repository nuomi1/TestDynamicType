//
//  FigureScaledTextView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-07-07.
//

import Foundation
import SwiftUI

struct FigureScaledTextView: View {

    let text: String

    var body: some View {
        Text(text)
            .font(.body)
            .debugBorder(isEnabled: true)
    }
}
