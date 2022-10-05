//
//  Attributes.swift
//  DevBucks
//
//  Created by Devanshu Dev Chaudhary on 02/10/22.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct OrderAttributes: ActivityAttributes {
    public typealias DeliveryStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var estimatedDeliveryTime: ClosedRange<Date>
    }

    var numberofCoffees: Int
    var selectedCoffee: String
}
