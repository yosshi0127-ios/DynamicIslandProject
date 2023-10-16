//
//  OrderAttributes.swift
//  DynamicIslandProject
//
//  Created by yosshi on 2023/10/13.
//

import SwiftUI
import ActivityKit

struct OrderAttributes: ActivityAttributes {

    struct ContentState: Codable, Hashable {
        var status: Status = .received
    }

    // MARK: Other Properties
    var orderNumber: Int
    var orderItems: String    
}


// MARK: Order Status
enum Status: String, CaseIterable, Codable, Equatable {
    case received = "snippingbox.fill"
    case progress = "person.bust"
    case ready = "takeoutbag.and.cup.and.straw.fill"
    
}
