//
//  ActivityCard.swift
//  MyHealthApp
//
//  Created by Magdalena Samuel on 11/14/23.
//

import SwiftUI

struct ActivityCard: View {
    @State var activity: ActivityModel

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            VStack(spacing: 25) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(activity.title)
                            .font(.system(size: 12))
                            .foregroundColor(.gray) // Updated to .foregroundColor
                        Text(activity.subtitle)
                            .font(.system(size: 16))
                    }

                    Spacer()

                    Image(systemName: activity.image)
                        .foregroundColor(activity.tintColor)
                }

                Text(activity.amount)
                    .font(.system(size: 23))
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.orange) // Updated to .foregroundColor
                    .bold()
                    .padding()
            }
            .padding()
        }
    }
}

struct ActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCard(activity: ActivityModel(id: 0, title: "Daily Steps", subtitle: "Goal: 10.000", image: "figure.walk", tintColor: .green, amount: "6500"))
    }
}

