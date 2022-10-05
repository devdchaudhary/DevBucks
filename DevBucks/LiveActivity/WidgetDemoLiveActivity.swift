//
//  WidgetDemoLiveActivity.swift
//  DevBucks
//
//  Created by Devanshu Dev Chaudhary on 02/10/22.
//

import ActivityKit
import WidgetKit
import SwiftUI

@main
struct Widgets: WidgetBundle {
   var body: some Widget {
       OrderActivity()
   }
}

struct OrderActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderAttributes.self) { _ in
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        HStack {
                            Text("Get Ready!")
                                .font(.title3)
                            Text("🤗")
                                .font(.title3)
                        }
                        Text("Your \(context.attributes.selectedCoffee) is on the way...")
                            .font(.title2)
                    }
                }
            } compactLeading: {
                Label {
                    Text("\(context.attributes.numberofCoffees) \(context.attributes.selectedCoffee)")
                } icon: {
                    Image(systemName: "cup.and.saucer.fill")
                }
                .font(.caption)
            } compactTrailing: {
                Text(timerInterval: context.state.estimatedDeliveryTime, countsDown: true)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .foregroundColor(.green)
            } minimal: {
                    Text(timerInterval: context.state.estimatedDeliveryTime, countsDown: true)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.subheadline)
            }
        }
    }
}
