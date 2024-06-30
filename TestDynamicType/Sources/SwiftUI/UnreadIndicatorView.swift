//
//  UnreadIndicatorView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-30.
//

import Foundation
import SwiftUI

struct UnreadIndicatorView: View {

    let isUnread: Bool

    var body: some View {
        Circle()
            .opacity(isUnread ? 1.0 : 0.0)
    }
}
