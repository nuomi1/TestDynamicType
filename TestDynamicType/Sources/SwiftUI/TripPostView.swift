//
//  TripPostView.swift
//  TestDynamicType
//
//  Created by nuomi1 on 2024-06-27.
//

import Foundation
import SwiftUI

struct TripPostView: View {

    let trip: Trip

    var body: some View {
        VStack(alignment: .center) {
            LabeledContent {
                Image(decorative: trip.image)
                    .resizable()
            } label: {
                Text(verbatim: trip.message)
            }
            .labeledContentStyle(PostLabeledContentStyle(
                postConfiguration: .init(
                    date: trip.date,
                    color: trip.color.color
                )
            ))

            Divider()
                .padding(.top)
        }
        .padding()
    }
}

struct PostLabeledContentStyle: LabeledContentStyle {

    let postConfiguration: PostConfiguration

    private let radius: CGFloat = 10

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.content
                .aspectRatio(contentMode: .fill)
                .frame(width: .infinity)
                .frame(maxHeight: 300)
                .clipShape(.rect(topLeadingRadius: radius, topTrailingRadius: radius))

            VStack(alignment: .leading) {
                Text(postConfiguration.date, format: .dateTime.weekday(.wide))
                    .textCase(.uppercase)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .padding(.top)

                configuration.label
                    .foregroundStyle(.white)
                    .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .background {
            RoundedRectangle(cornerRadius: radius)
                .shadow(radius: radius)
                .foregroundStyle(postConfiguration.color.primaryMix)
        }
    }
}

extension PostLabeledContentStyle {

    struct PostConfiguration {
        var date: Date
        var color: Color
    }
}
